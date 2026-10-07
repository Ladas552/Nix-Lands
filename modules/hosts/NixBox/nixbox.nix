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

      networking.useDHCP = false;
      networking.interfaces."enp1s0".useDHCP = true;
      networking.interfaces."enp2s0".ipv4.addresses = [
        {
          address = "192.168.10.1";
          prefixLength = 24;
        }
      ];

      # Routing + NAT
      networking.nat = {
        enable = true;
        externalInterface = "enp1s0";
        internalInterfaces = [ "enp2s0" ];
      };

      # Firewall: nothing open on WAN, DHCP/DNS/SSH open on LAN only
      networking.firewall = {
        enable = true;
        interfaces."enp2s0" = {
          allowedUDPPorts = [
            53
            67
          ];
          allowedTCPPorts = [
            53
            22
          ];
        };
      };

      # DHCP + DNS for the PC
      services.dnsmasq = {
        enable = true;
        settings = {
          interface = "enp2s0";
          bind-interfaces = true;
          dhcp-range = "192.168.10.100,192.168.10.200,12h";
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
