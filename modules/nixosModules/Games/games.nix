{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { pkgs, ... }:
    {
      environment.shellAliases = {
        game-osu = "env XKB_DEFAULT_LAYOUT=canary gamescope --backend drm -g --force-grab-cursor -W 1920 -H 1200 osu!";
      };

      environment.systemPackages = with pkgs; [
        # Launchers
        # bottles
        # heroic
        prismlauncher
        # PC games
        osu-lazer-bin
        # arx-libertatis
        # stepmania
        # openmw
        # daggerfall-unity
        # luanti
        # mindustry
        # steam-run
        antimatter-dimensions
      ];
      # persist games
      custom.imp.home = {
        directories = [
          "Games"
          ".config/arx"
          ".config/openmw"
          ".config/unity3d"
          ".config/Antimatter Dimensions"
          ".local/share/Mindustry"
          ".local/share/PrismLauncher"
          ".local/share/arx"
          ".local/share/bottles"
          ".local/share/openmw"
          ".local/share/osu"
          ".local/share/Terraria"
        ];
      };
    };
}
