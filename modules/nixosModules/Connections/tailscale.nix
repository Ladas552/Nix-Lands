{
  hosts = [
    "pc"
    "laptop"
    "server"
    "vps"
  ];
  config =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/tailnet".neededForUsers = true;
      sops.secrets."mystuff/tailnet" = { };

      # module
      services.tailscale = {
        enable = true;
        openFirewall = true;
        # expires after 90 days
        authKeyFile = "${config.sops.secrets."mystuff/tailnet".path}";
        permitCertUid = "caddy";
        disableUpstreamLogging = true;
      };
      # https://wiki.nixos.org/wiki/Tailscale#No_internet_when_using_exit_node
      # networking.firewall.checkReversePath = "loose";

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/tailscale/" ];
    };
}
