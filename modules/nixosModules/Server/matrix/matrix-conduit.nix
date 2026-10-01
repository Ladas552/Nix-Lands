{
  # settings and well-known is stolen from @poz https://git.poz.pet/poz/niksos/src/commit/ca0170d49dcf01b9318e0eaaddf0a0e92aab5c74/hosts/szparag/services/conduit.nix
  # To create user, enable registration with plain text token, rebuild, register,        disable registration, and rebuild. All without commiting changes to git.
  # Stupid system, but what can you do.
  enable = false;
  hosts = [ "server" ];
  config = {
    services.matrix-conduit = {
      enable = true;
      settings.global = {
        address = "0.0.0.0";
        server_name = "ladas552.me";
        proxy.global.url = "socks5://100.90.144.20:1080"; # connect to microsocks of my VPS
        database_backend = "rocksdb";
        port = 6161;
        enable_lightning_bolt = false;
        max_request_size = 104857600;
        allow_check_for_updates = false;
        allow_registration = false;
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 6161 ];

    # persist for Impermanence
    custom.imp.root.directories = [ "/var/lib/matrix-conduit" ];
  };
}
