{
  config =
    {
      lib,
      pkgs,
      ...
    }:
    {
      boot = {
        initrd.systemd.enable = true;
        loader = {
          systemd-boot = {
            enable = true;
            consoleMode = "2";
            edk2-uefi-shell = {
              enable = true;
              sortKey = "x_edk2-uefi-shell";
            };
            # no wait until boot, press `space` to get the menu
            extraInstallCommands = # sh
              ''
                ${lib.getExe' pkgs.gnused "sed"} -i '/timeout 5/c\timeout 0' /boot/loader/loader.conf
              '';
          };
          efi = {
            efiSysMountPoint = "/boot";
            canTouchEfiVariables = true;
          };
        };
      };
    };
}
