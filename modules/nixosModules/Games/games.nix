{
  hosts = [
    "pc"
  ];
  config =
    { pkgs, ... }:
    {
      environment.shellAliases = {
        play-osu = "env XKB_DEFAULT_LAYOUT=canary,ru obs-gamecapture gamescope -g -f osu!";
        play-osu-drm = "env XKB_DEFAULT_LAYOUT=canary,ru obs-gamecapture gamescope --backend drm -g osu!";
        play-steam = "obs-gamecapture gamescope -e -f steam";
        play-steam-drm = "obs-gamecapture gamescope --backend drm -g -e steam";
      };

      environment.systemPackages = with pkgs; [
        # Launchers
        # lutris
        # heroic
        prismlauncher
        # PC games
        osu-lazer-bin
        # arx-libertatis
        # stepmania
        openmw
        daggerfall-unity
        # luanti
        # mindustry
        steam-run
        # antimatter-dimensions
        # Emulators I am not putting on my laptop
        shadps4-qtlauncher
        # Utils
        mangohud
      ];
      # persist games
      custom.imp.home = {
        directories = [
          "Games"
          ".config/Antimatter Dimensions"
          ".config/StardewValley"
          ".config/arx"
          ".config/openmw"
          ".config/unity3d"
          ".local/share/Mindustry"
          ".local/share/PrismLauncher"
          ".local/share/Terraria"
          ".local/share/arx"
          # ".local/share/bottles"
          ".local/share/godot"
          ".local/share/openmw"
          ".local/share/osu"
          ".local/share/shadPS4"
          ".local/share/umu"
          # ".local/share/lutris"
          ".local/share/Celeste"
          ".local/share/Overgrowth"
          ".local/share/SuperMeatBoy"
          ".local/share/HotlineMiami"
          ".local/share/binding of isaac afterbirth+"
          ".local/share/binding of isaac afterbirth+ mods"
        ];
      };
    };
}
