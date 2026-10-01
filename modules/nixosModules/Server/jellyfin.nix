{
  hosts = [ "server" ];
  config = {
    services.jellyfin = {
      enable = true;
      group = "media";
    };
    users.users."jellyfin".extraGroups = [ "media" ];
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
      8096
      8920
    ];

    # Reverse proxy
    services.caddy.virtualHosts."jellyfin.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:8096
      '';
    };

    # persist for Impermanence
    custom.imp.root.directories = [
      "/var/lib/jellyfin"
      "/var/cache/jellyfin"
    ];
  };
}
