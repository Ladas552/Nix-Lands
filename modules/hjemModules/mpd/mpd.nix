{
  hosts = [ "pc" "laptop" ];
  config =
    {
      config,
      pkgs,
      self,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        mpc
        self.packages.${pkgs.stdenv.hostPlatform.system}.musnow
      ];

      hj = {
        services.mpdris2.enable = true;

        services.mpd = {
          enable = true;
          musicDirectory = config.hj.xdg.userDirs.music.directory;
          extraConfig = ''
            audio_output {
              type "pipewire"
              name "Pipewire Sounds Server"
            }
            audio_output {
              type               "fifo"
              name               "toggle_visualizer"
              path               "/tmp/mpd.fifo"
              format             "44100:16:2"
            }
            auto_update "yes"
            metadata_to_use "artist, album, title, track, name, genre, date, composer, performer, disc, comment"
          '';
        };
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/mpd" ];
    };
}
