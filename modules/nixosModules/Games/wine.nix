{
  hosts = [ "pc" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        winePackages.stagingFull
        winetricks
      ];
      custom.imp.home.cache.directories = [
        ".wine"
        ".local/share/wineprefixes"
        ".cache/winetricks"
      ];
    };
}
