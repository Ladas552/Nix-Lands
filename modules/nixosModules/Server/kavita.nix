{
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/kavita".neededForUsers = true;
      sops.secrets."mystuff/kavita" = { };
      # module
      services.kavita = {
        enable = true;
        tokenKeyFile = config.sops.secrets."mystuff/kavita".path;
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
