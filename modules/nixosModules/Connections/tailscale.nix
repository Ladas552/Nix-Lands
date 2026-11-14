{
  hosts = [
    "pc"
    "laptop"
    "server"
    "vps"
    "iso"
  ];
  config =
    { config, lib, ... }:
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

      # tailscaled-autoconnect takes 10 seconds from my boot time, idk why, and this below doesn't fix it, but worth a shot
      # stolen from https://github.com/heraldofsolace/nixos-config/blob/df7b5b183e684db36868c9e1f79f558b634d554d/modules/aspects/network/security.nix#L76
      systemd.services.tailscaled-autoconnect.before = lib.mkForce [ "shutdown.target" ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/tailscale" ];
    };
}
