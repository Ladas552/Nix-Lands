{
  hosts = [ "server" ];
  config =
    { config, inputs, ... }:
    {
      # secrets
      secrets."copypartyl" = {
        owner = "copyparty";
        group = "media";
      };

      # import module
      imports = [ inputs.copyparty.nixosModules.default ];

      # module
      services.copyparty = {
        enable = true;
        user = "copyparty";
        group = "media";
        settings = {
          i = "0.0.0.0";
          p = 3210;
        };
        accounts.admin.passwordFile = config.secrets."copypartyl".path;
        volumes = {
          "/" = {
            path = "/srv/media/copyparty";
            access.A = "admin";
          };
          "/media" = {
            path = "/srv/media";
            access.A = "admin";
          };
          "/docs" = {
            path = "/home/ladas552/Documents";
            access.A = "admin";
          };
        };
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
        config.services.copyparty.settings.p
      ];

      # Reverse proxy
      services.caddy.virtualHosts."copyparty.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:3210
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/copyparty"
      ];
    };
}
