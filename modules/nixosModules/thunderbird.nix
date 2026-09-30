{
  hosts = [
    "pc"
    "laptop"
  ];
  config = { wrappers, ... }: {
    environment.systemPackages = [
      wrappers.thunderbird.drv
    ];

    # persist for Impermanence
    custom.imp.home = {
      directories = [ ".thunderbird" ];
      cache.directories = [ ".cache/thunderbird" ];
    };
  };
}
