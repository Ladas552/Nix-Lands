{
  hosts = [ "server" ];
  config = {
    # music database service, to then connect with Symfonium
    services.gonic = {
      enable = true;
      settings = {
        listen-addr = "0.0.0.0:4747";
        music-path = [ "/srv/media/Music" ];
        playlists-path = "/var/lib/gonic/playlist";
        podcast-path = "/var/lib/gonic/podcast";
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 4747 ];

    # Reverse proxy
    services.caddy.virtualHosts."gonic.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:4747
      '';
    };

    # persist for Impermanence
    custom.imp.root.directories = [
      "/var/cache/gonic"
      "/var/lib/gonic"
    ];
  };
}
