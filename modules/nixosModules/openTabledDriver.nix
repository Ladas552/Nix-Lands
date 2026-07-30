{
  hosts = [ "laptop" ];
  config = {
    # Configure tablet
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".config/OpenTabletDriver" ];
  };
}
