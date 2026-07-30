{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;

  ini = pkgs.formats.ini { };
  cfg = config.services.mpdris2;
in
{
  options.services.mpdris2 = {
    settings = mkOption {
      type = ini.type;
      default = {
        Connection = {
          host = config.services.mpd.network.listenAddress;
          port = config.services.mpd.network.port;
          music_dir = config.services.mpd.musicDirectory;
        };
        Bling = {
          notify = true;
          mmkeys = true;
        };
      };
    };
    enable = mkEnableOption "mpdris2";

    package = mkPackageOption pkgs "mpdris2" { };

  };

  config = mkIf cfg.enable {
    xdg.config.files."mpDris2/mpDris2.conf".source = ini.generate "mpdris2" cfg.settings;
    systemd.services.mpdris2 = {
      wantedBy = [ "default.target" ];
      description = "MPRIS 2 support for MPD";
      after = [ "mpd.service" ];
      path = [ cfg.package ];
      script = "mpDris2";
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "5s";
        BusName = "org.mpris.MediaPlayer2.mpd";
      };
    };
  };
}
