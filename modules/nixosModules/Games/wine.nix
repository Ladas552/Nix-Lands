{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # wine
        winePackages.stagingFull
        winetricks
      ];

    };
}
