{
  hosts = [ "server" ];
  config =
    { pkgs,meta,...}:
    {
      _module.args = {
        meta = {
          hostname = "NixBox";
          configPath = "/home/ladas552/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        rcon-cli
        sqlite
      ];

      # Build machine for NixWool
      # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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

      # Define a user account. Check Impermanence Module for user password
      users.users."${meta.user}".extraGroups = [ "media" ];
      ## Stuff to make server operatable
      users.groups."media" = { };

      ##### ZFS MOUNT POINTS
      ##### Because I have additional drive for NixToks
      fileSystems."/mnt/zmedia" = {
        device = "zmedia/files";
        fsType = "zfs";
      };
      # media files for torrents and stuff on main drive
      fileSystems."/srv/media" = {
        device = "zroot/media";
        fsType = "zfs";
      };
    };

}
