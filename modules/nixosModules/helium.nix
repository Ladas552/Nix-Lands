{
  hosts = [ "iso" ];
  config =
    { pkgs, inputs, ... }:
    {
      environment.systemPackages = [
        inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.helium-widevine
      ];

      custom.imp.home.cache.directories = [
        ".cache/net.imput.helium"
        ".config/net.imput.helium"
      ];
    };
}
