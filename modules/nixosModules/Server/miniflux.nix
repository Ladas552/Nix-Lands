{
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/minifluxl" = { };
      sops.secrets."mystuff/minifluxp" = { };
      sops.templates."miniflux-admin-credentials".content = ''
        ADMIN_USERNAME="${config.sops.placeholder."mystuff/minifluxl"}"
        ADMIN_PASSWORD="${config.sops.placeholder."mystuff/minifluxp"}"
      '';

      # module
      services.miniflux = {
        enable = true;
        adminCredentialsFile = "${config.sops.templates."miniflux-admin-credentials".path}";
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
