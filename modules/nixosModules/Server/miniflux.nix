{
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # secrets
      secrets."minifluxl" = { };
      secrets."minifluxp" = { };
      security.nix-secrets.templates."miniflux-admin-credentials".content = ''
        ADMIN_USERNAME="${config.secrets."minifluxl"}"
        ADMIN_PASSWORD="${config.secrets."minifluxp"}"
      '';

      # module
      services.miniflux = {
        enable = true;
        adminCredentialsFile = "${config.security.nix-secrets.templates."miniflux-admin-credentials".path}";
        config = {
          LISTEN_ADDR = "localhost:8067";
          CREATE_ADMIN = true;
          LOG_DATE_TIME = "1";

          FETCH_BILIBILI_WATCH_TIME = "1";
          FETCH_NEBULA_WATCH_TIME = "1";
          FETCH_ODYSEE_WATCH_TIME = "1";
          FETCH_YOUTUBE_WATCH_TIME = "1";

        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."miniflux.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:8067
        '';
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8067 ];

      # idk what to persist for miniflux, probably postgress
      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/postgresql"
      ];
    };
}
