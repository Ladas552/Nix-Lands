{
  hosts = [ "server" ];
  config =
    { config, pkgs, ... }:
    {
      # secrets
      sops.secrets."mystuff/nextcloud".neededForUsers = true;
      sops.secrets."mystuff/nextcloud" = { };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8080 ];

      # Proxy
      # Nextcloud got hard dependency on nginx, i tried to remove it before, it worked, but didn't remove nginx outright
      # https://github.com/Ladas552/Nix-Is-Unbreakable/commit/2795a648c92b986df438787737add83f7961bfa6
      services.nginx = {
        enable = true;
        virtualHosts = {
          "nextcloud.ladas552.me" = {
            listen = [
              {
                addr = "0.0.0.0";
                port = 8080;
              }
            ];
          };
        };
      };

      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
          {
            name = "nextcloud";
            ensureDBOwnership = true;
          }
        ];
      };
      systemd.services."nextcloud-setup" = {
        requires = [ "postgresql.service" ];
        after = [ "postgresql.service" ];
      };

      users.users."nextcloud".extraGroups = [ "media" ];

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud34;
        configureRedis = true;
        maxUploadSize = "50G";
        hostName = "nextcloud.ladas552.me";
        settings.trusted_domains = [ "nextcloud.ladas552.me" ];
        config = {
          dbtype = "pgsql";
          dbuser = "nextcloud";
          dbhost = "/run/postgresql";
          dbname = "nextcloud";
          adminuser = "ladas552";
          adminpassFile = config.sops.secrets."mystuff/nextcloud".path;
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."nextcloud.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/nextcloud"
        "/var/lib/redis-nextcloud"
      ];
    };
}
