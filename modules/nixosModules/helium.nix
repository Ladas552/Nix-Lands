{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, self, ... }:
    {
      environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helium ];

      custom.imp.home.cache.directories = [
        ".cache/net.imput.helium"
        ".config/net.imput.helium"
      ];
    };
}
