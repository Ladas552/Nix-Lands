{
  enable = false;
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # secrets
      secrets."kavita".neededForUsers = true;
      # module
      services.kavita = {
        enable = true;
        tokenKeyFile = config.secrets."kavita".path;
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 5000 ];
      users.users."kavita".extraGroups = [ "media" ];

      # Reverse proxy
      services.caddy.virtualHosts."kavita.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:5000
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/kavita"
      ];
    };
}
