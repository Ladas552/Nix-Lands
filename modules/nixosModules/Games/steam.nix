{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { pkgs, ... }:
    {
      # Steam
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        # gamescopeSession.enable = true;
        extraCompatPackages = [
          pkgs.proton-ge-bin.steamcompattool
          pkgs.mangohud
        ];
      };
      programs.gamescope = {
        enable = true;
        env = {
          XKB_DEFAULT_LAYOUT = "us,ru";
          XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
        };
        args = [
          "--force-grab-cursor"
          "-W 1920"
          "-H 1080"
          "-r 240"
        ];
        enableWsi = true;
        # without this gamescope lags
        capSysNice = true;
      };
      hardware.steam-hardware.enable = true;
      environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      programs.gamemode.enable = true; # huge battery drains on my laptop
      # persist steam
      custom.imp.home.cache.directories = [
        ".local/share/Steam"
        ".cache/mesa_shader_cache"
        ".cache/mesa_shader_cache_db"
        ".cache/radv_builtin_shaders"
      ];
    };
}
