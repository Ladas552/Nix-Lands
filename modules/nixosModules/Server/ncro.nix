{
  enable = false;
  hosts = [ "server" ];
  config =
    { inputs, pkgs, ... }:
    let
      port = 6829;
    in
    {
      # proxy cache across all systems on the network
      # config stolen from @rysieko at https://tangled.org/did:plc:r6znfbtinv4yhwfpuxdsdvgn
      imports = [ inputs.ncro.nixosModules.default ];
      services.ncro = {
        enable = true;
        package = (
          inputs.ncro.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs { doCheck = false; }
        );

        inherit port;
        openFirewall = false;
        addUpstreamPublicKeys = false;
        socketActivation = true;
        settings = {
          upstreams = [
            {
              url = "https://cache.nixos.org";
              priority = 10;
              public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
            }
            {
              url = "https://nix-community.cachix.org";
              priority = 5;
              public_key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
            }
            {
              url = "https://circus.ladas552.me/projects/Nix-Lands/nix-cache/";
              priority = 20;
              public_key = "circus.ladas552.me-1:Zs4de2JNShhtJhjJTorpuEb+CLjth/xn8e9uNM1XBy4=";
            }
          ];
          server.listen = "localhost:${toString port}";
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."ncro.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:${toString port}
        '';
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ port ];

      # persist for Impermanence
      system.nixos-core.persistence.stores."/cache".directories = [
        {
          target = "/var/lib/private/ncro";
          owner = "nobody";
          group = "nogroup";
        }
      ];
    };
}
