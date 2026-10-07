{
  hosts = [
    "finix"
  ];
  config =
    {
      meta,
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

      boot = {
        supportedFilesystems.zfs = true;
        initrd.supportedFilesystems.zfs.enable = true;
      };
      services.zfs = {
        autoScrub.enable = true;
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
      environment.shellAliases = { } // aliases;
    };
}
