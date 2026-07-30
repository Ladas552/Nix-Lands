{
  enable = false;
  hosts = [ "server" ];
  config = {
    # proxy cache across all systems on the network
    services.ncps = {
      enable = true;
      cache = {
        hostName = "ncps.ladas552.me";
        upstream = {
          publicKeys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
          urls = [ "https://cache.nixos.org" ];
        };
      };
    };

    # Reverse proxy
    services.caddy.virtualHosts."ncps.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:8501
      '';
    };

    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8501 ];

    # persist for Impermanence
    custom.imp.root.directories = [ "/var/lib/ncps" ];
  };
}
