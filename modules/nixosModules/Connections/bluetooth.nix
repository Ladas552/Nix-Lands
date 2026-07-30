{
  hosts = [ "laptop" ];
  config = {
    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;

    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    # persist for Impermanence
    custom.imp.root.directories = [ "/var/lib/bluetooth" ];

    hj.services.mpris-proxy.enable = true;
  };
}
