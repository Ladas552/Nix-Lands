{
  hosts = [ "iso" ];
  config =
    { wrappers, ... }:
    {
      environment.systemPackages = [ wrappers.helium ];

      custom.imp.home.cache.directories = [
        ".cache/net.imput.helium"
        ".config/net.imput.helium"
      ];
    };
}
