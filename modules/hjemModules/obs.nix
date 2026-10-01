{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { pkgs, ... }:
    {
      hj.rum.programs.obs-studio = {
        enable = true;
        package = pkgs.wrapOBS.override { obs-studio = pkgs.obs-studio; } {
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            # need to launch game with obs-gamecapture %command% command
            # or this one env OBS_VKCAPTURE=1 %command%
            obs-vkcapture
            obs-pipewire-audio-capture
          ];
        };
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".config/obs-studio" ];
    };
}
