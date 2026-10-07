{
  hosts = [
    "pc"
  ];
  config =
    { pkgs, ... }:
    {
      environment.shellAliases = {
        play-osu = "env XKB_DEFAULT_LAYOUT=canary,ru XKB_DEFAULT_OPTIONS=grp:caps_toggle gamescope -g -f --force-grab-cursor -W 1920 -H 1080 -r 240 osu!";
        play-osu-drm = "env XKB_DEFAULT_LAYOUT=canary,ru XKB_DEFAULT_OPTIONS=grp:caps_toggle gamescope --backend drm -g --force-grab-cursor -W 1920 -H 1080 -r 240 osu!";
        play-steam = "env XKB_DEFAULT_LAYOUT=us,ru XKB_DEFAULT_OPTIONS=grp:caps_toggle gamescope -e -f --force-grab-cursor -W 1920 -H 1080 -r 240 steam";
        play-steam-drm = "env XKB_DEFAULT_LAYOUT=us,ru XKB_DEFAULT_OPTIONS=grp:caps_toggle gamescope --backend drm -g -e --force-grab-cursor -W 1920 -H 1080 -r 240 steam";
      };

      environment.systemPackages = with pkgs; [
        # Launchers
        bottles
        # heroic
        prismlauncher
        # PC games
        osu-lazer-bin
        arx-libertatis
        stepmania
        openmw
        daggerfall-unity
        luanti
        # mindustry
        steam-run
        antimatter-dimensions
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
          ".local/share/bottles"
          ".local/share/godot"
          ".local/share/openmw"
          ".local/share/osu"
          ".local/share/shadPS4"
          ".local/share/umu"
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
