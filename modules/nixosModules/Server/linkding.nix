{
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # Secrets
      secrets."linkding-db-pass" = { };
      secrets."linkding-user-pass" = { };
      security.nix-secrets.templates."linkding".content = ''
        LD_DB_PASSWORD ="${config.secrets."linkding-db-pass"}"
        LD_SUPERUSER_PASSWORD ="${config.secrets."linkding-user-pass"}"
      '';

      # module
      services.linkding = {
        enable = true;
        environmentFile = config.security.nix-secrets.templates."linkding".path;
        settings.LD_SUPERUSER_NAME = "admin";
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
        9090
      ];

      # Reverse proxy
      services.caddy.virtualHosts."linkding.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:9090
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/linkding"
      ];
    };
}
