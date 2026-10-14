{
  hosts = [ "server" ];
  config =
    { pkgs, meta, ... }:
    {
      _module.args = {
        meta = {
          hostname = "NixBox";
          configPath = "/persist/home/ladas552/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        # minecraft server admin console
        rcon-cli
        sqlite
      ];

      # Enable OpenGL and hardware accelerated graphics drivers

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          intel-media-driver
          # Mirrors are down for the whole month. Intel should die
          # intel-ocl
          vpl-gpu-rt
        ];
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "26.11"; # Did you read the comment?

      ## Powermanagment
      ## It disabled usb after some time of incativity, so not usable on desktop
      powerManagement.powertop.enable = true;

      # I save all media under the same group so they all can be shared acros different services
      users.groups."media" = { };
      users.users."${meta.user}".extraGroups = [ "media" ];

      # media files for torrents and stuff on sata ssd
      fileSystems."/srv" = {
        device = "zmedia/media";
        fsType = "zfs";
      };

      networking.bridges.br0.interfaces = [
        "enp2s0"
        "enp3s0"
        "enp4s0"
      ];
      networking.interfaces.br0.ipv4.addresses = [
        {
          address = "192.168.10.1";
          prefixLength = 24;
        }
      ];

      networking.nat = {
        enable = true;
        externalInterface = "enp1s0";
        internalInterfaces = [ "br0" ];
      };

      networking.firewall.interfaces."br0" = {
        allowedUDPPorts = [
          67
          53
        ];
        allowedTCPPorts = [ 53 ];
      };

      services.dnsmasq = {
        enable = true;
        settings = {
          interface = "br0";
          bind-interfaces = true;
          dhcp-range = "192.168.10.100,192.168.10.200,12h";
          dhcp-option = "option:dns-server,1.1.1.1,9.9.9.9";
          server = [
            "1.1.1.1"
            "9.9.9.9"
          ];
        };
      };

      # for iperf3 -s
      networking.firewall.allowedTCPPorts = [ 5201 ];

      # persist the config directory
      custom.imp.home.directories = [ "Nix-Lands" ];
    };

}
