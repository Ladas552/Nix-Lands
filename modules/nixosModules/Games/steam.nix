{
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      # Steam
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        # gamescopeSession.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];
      };
      hardware.steam-hardware.enable = true;
      environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      programs.gamemode.enable = true; # huge battery drains on my laptop
      environment.systemPackages = [ pkgs.gamescope ];
      # persist steam
      custom.imp.home.cache.directories = [
        ".local/share/Steam"
        ".cache/mesa_shader_cache"
        ".cache/mesa_shader_cache_db"
        ".cache/radv_builtin_shaders"
      ];
    };
}
