{
  hosts = [
    "pc"
    "laptop"
    "server"
    "vps"
  ];
  config =
    {
      meta,
      config,
      lib,
      ...
    }:
    let
      aliases = {
        zfs-list = "zfs list -o name,lused,used,avail,compressratio,mountpoint";
        zfs-snapshots = "zfs list -t snapshot -S creation -o name,creation,used,written,refer";
      };
    in
    {
      # generate hostID for ZFS using hostname of the machine
      # or you can put a string manually, from this command
      # head -c 8 /etc/machine-id
      networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" meta.hostname);

      # NOTE: zfs datasets are created manually
      # Stolen from @iynaix and @xarvex, like the whole thing
      boot = {
        supportedFilesystems.zfs = true;
        zfs = {
          forceImportRoot = true;
          devNodes =
            if config.hardware.cpu.intel.updateMicrocode then "/dev/disk/by-id" else "/dev/disk/by-partuuid";
        };
      };
      services.zfs = {
        autoScrub.enable = true;
        trim.enable = true;
      };
      # standardized filesystem layout
      fileSystems = {
        "/" = {
          device = "zroot/root";
          fsType = "zfs";
          neededForBoot = true;
        };
        # boot partition
        "/boot" = {
          device = "/dev/disk/by-label/NIXBOOT";
          fsType = "vfat";
        };
        "/nix" = {
          device = "zroot/nix";
          fsType = "zfs";
        };
        # by default, /tmp is not a tmpfs on nixos as some build artifacts can be stored there
        # when using / as a small tmpfs for impermanence, /tmp can then easily run out of space,
        # so create a dataset for /tmp to prevent this
        # /tmp is cleared on boot via `boot.tmp.cleanOnBoot = true;
        "/tmp" = {
          device = "zroot/tmp";
          fsType = "zfs";
        };
        # cache are files that should be persisted, but not to snapshot
        # e.g. npm, cargo cache etc, that could always be redownload
        "/cache" = {
          device = "zroot/cache";
          fsType = "zfs";
          neededForBoot = true;
        };
      };
      # https://github.com/openzfs/zfs/issues/10891
      systemd.services = {
        systemd-udev-settle.enable = false;
      };
      services.sanoid = {
        enable = true;
        datasets = lib.mkDefault {
          "zroot/root" = {
            hourly = 50;
            daily = 15;
            weekly = 3;
            monthly = 1;
          };
        };
      };
      environment.shellAliases = { } // aliases;
    };
}
