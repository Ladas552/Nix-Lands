{
  # hosted on my most powerfull gpu, which is my pc's rx6700xt
  enable = false;
  hosts = [ "pc" ];
  config =
    { pkgs, ... }:
    {
      services.ollama = {
        enable = true;
        user = "ollama";
        package = pkgs.ollama-rocm;
        rocmOverrideGfx = "10.3.0"; # rx6700xt
        # I am not adding modules declarativly because the option doesn't work reliably.
        host = "[::]";
      };

      # Reverse proxy
      services.caddy.virtualHosts."ollama.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:11434
        '';
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 11434 ];

      # persist for Impermanence
      system.nixos-core.persistence.stores."/cache".directories = [
        {
          target = "/var/lib/private/ollama";
          owner = "nobody";
          group = "nogroup";
        }
      ];
    };
}
