{
  hosts = [
    "laptop"
    "vps"
  ];
  config =
    {
      config,
      lib,
      meta,
      ...
    }:
    let
      cfg = config.custom.imp;
    in

    {
      # persist mount
      fileSystems."/persist" = {
        device = "zroot/persist";
        fsType = "zfs";
        neededForBoot = true;
      };
      # replace the root mount with tmpfs
      # wipes everything if you don't have proper persists, be warned
      fileSystems."/" = lib.mkForce {
        device = "tmpfs";
        fsType = "tmpfs";
        neededForBoot = true;
        options = [
          "defaults"
          # whatever size feels comfortable, smaller is better
          "size=1G"
          "mode=755"
        ];
      };

      services.sanoid = {
        enable = true;
        datasets = lib.mkForce {
          "zroot/persist" = {
            hourly = 50;
            daily = 15;
            weekly = 3;
            monthly = 1;
          };
        };
      };
      # clean /tmp
      boot.tmp.cleanOnBoot = true;

      # sudo lectures about rules when using root
      security.sudo.extraConfig = "Defaults lecture=never";

      # merge all persists into abstraction
      system.nixos-core.persistence = {
        enable = true;
        stores."/persist" = {
          files = lib.unique cfg.root.files;
          directories = lib.unique cfg.root.directories;
          users."${meta.user}" = {
            files = lib.unique cfg.home.files;
            directories = lib.unique cfg.home.directories;
          };
        };
        stores."/cache" = {
          files = lib.unique cfg.root.cache.files;
          directories = lib.unique cfg.root.cache.directories;
          users."${meta.user}" = {
            files = lib.unique cfg.home.cache.files;
            directories = lib.unique cfg.home.cache.directories;
          };
        };
      };
    };
}
