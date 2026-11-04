{
  hosts = [ "server" ];
  config = {
    # music database service, to then connect with Symfonium
    services.navidrome = {
      enable = true;
      group = "media";
      settings = {
        MusicFolder = "/srv/media/Music";
        LogLevel = "warn";
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 4533 ];

    # Reverse proxy
    services.caddy.virtualHosts."navidrome.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:4533
      '';
    };

    # persist for Impermanence
    system.nixos-core.persistence.stores."/cache".directories = [
      {
        target = "/var/lib/navidrome";
        owner = "navidrome";
        group = "media";
      }
    ];
  };
}
