{
  hosts = [ "server" ];
  config = {
    # module
    services.immich = {
      enable = true;
      openFirewall = false; # Only allow specific ports for specific networks
      machine-learning.enable = false; # Doesn't seem to work on my nvidia 860m
    };

    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 2283 ];

    # Reverse proxy
    services.caddy.virtualHosts."immich.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };

    # persist for Impermanence
    custom.imp.root.directories = [
      "/var/lib/immich"
      "/var/lib/redis-immich"
      "/var/cache/immich"
    ];
  };
}
