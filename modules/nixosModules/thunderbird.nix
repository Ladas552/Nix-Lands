{
  hosts = [
    "pc"
    "laptop"
  ];
  config = { self, pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.thunderbird
    ];

    # persist for Impermanence
    custom.imp.home = {
      directories = [ ".thunderbird" ];
      cache.directories = [ ".cache/thunderbird" ];
    };
  };
}
