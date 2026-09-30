{
  enable = false;
  games =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # wine
        winePackages.stagingFull
        winetricks
      ];

    };
}
