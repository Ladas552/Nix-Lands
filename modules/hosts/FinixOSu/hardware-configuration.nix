{
  hosts = [ "finix" ];
  config =
    { pkgs, ... }:

    {
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      # WARN: If you dont set this you potentially won't be able to boot your machine.
      hardware.firmware = [ pkgs.linux-firmware ];

      swapDevices = [ { label = "SWAP"; } ];
    };
}
