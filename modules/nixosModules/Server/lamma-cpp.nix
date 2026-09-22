{
  # hosted on my most powerfull gpu, which is my pc's rx6700xt
  hosts = [ "pc" ];
  config =
    { pkgs, ... }:
    {
      services.llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
        settings = {
          port = 11433;
          # get the model automatically from hugging face
          # gemma 4 12b at 36t/s, can't process images tho
          hf-repo = "unsloth/gemma-4-12b-it-GGUF";
          hf-file = "gemma-4-12b-it-Q4_K_M.gguf";

          # whatever slop suggested
          gpu-layers = 99; # offload everything, capped at model's real layer count
          ctx-size = 8192; # raise once you confirm it fits in 12GB
          flash-attn = "auto"; # "on" can SIGABRT on gfx1031 — test manually before forcing it
          cache-type-k = "f16"; # don't quantize KV cache yet — pairs badly with FA issues on RDNA2
          cache-type-v = "f16";

          batch-size = 512; # default
          ubatch-size = 128; # lower than default 512 — RDNA2 often does better with smaller ubatch

          temp = 1.0;
          top-p = 0.95;
          top-k = 64;
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."llama-cpp.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:11433
        '';
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 11433 ];

      # persist for Impermanence
      system.nixos-core.persistence.stores."/cache".directories = [
        {
          target = "/var/lib/private/llama-cpp";
          owner = "nobody";
          group = "nogroup";
        }
        {
          target = "/var/cache/private/llama-cpp";
          owner = "nobody";
          group = "nogroup";
        }
      ];
    };
}
