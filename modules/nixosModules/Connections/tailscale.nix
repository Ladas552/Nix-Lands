{
  hosts = [
    "pc"
    "laptop"
    "server"
    "vps"
    "iso"
  ];
  config =
    { config, ... }:
    {
      # secrets
      secrets."tailnet".neededForUsers = true;

      # module
      services.tailscale = {
        enable = true;
        openFirewall = true;
        # expires after 90 days, dec 10
        authKeyFile = "${config.secrets."tailnet".path}";
        permitCertUid = "caddy";
        disableUpstreamLogging = true;
      };
      # https://wiki.nixos.org/wiki/Tailscale#No_internet_when_using_exit_node
      # networking.firewall.checkReversePath = "loose";

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/tailscale/" ];
    };
}
