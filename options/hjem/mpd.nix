{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.types)
    path
    lines
    str
    port
    ;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (pkgs) writeText;

  cfg = config.services.mpd;
in
{
  # no extra args for the mpd binary
  # broken socket dependency, needs requiremnts
  options.services.mpd = {
    enable = mkEnableOption "mpd";

    package = mkPackageOption pkgs "mpd" { nullable = true; };

    musicDirectory = mkOption {
      type = path;
      apply = toString; # Prevent copies to Nix store.
      default = "${config.xdg.userDirs.music.directory}";
    };

    playlistDirectory = mkOption {
      type = path;
      apply = toString; # Prevent copies to Nix store.
      default = "${cfg.dataDir}/playlists";
    };

    dataDir = mkOption {
      type = path;
      apply = toString; # Prevent copies to Nix store.
      default = "${config.xdg.data.directory}/mpd";
    };
    dbFile = mkOption {
      type = path;
      apply = toString; # Prevent copies to Nix store.
      default = "${cfg.dataDir}/tag_cache";
    };

    network = {
      startWhenNeeded = mkEnableOption {
        default = false;
        description = "Enable systemd socket activation. This is only supported on Linux.";
      };

      listenAddress = mkOption {
        type = str;
        default = "127.0.0.1";
        example = "any";
        description = ''
          The address for the daemon to listen on.
          Use `any` to listen on all addresses.
        '';
      };

      port = mkOption {
        type = port;
        default = 6600;
        description = ''
          The TCP port on which the the daemon will listen.
        '';
      };

    };

    extraConfig = mkOption {
      type = lines;
      default = "";
    };
  };
  config =
    let
      mpdConf = writeText "mpd.conf" ''
        music_directory     "${cfg.musicDirectory}"
        playlist_directory  "${cfg.playlistDirectory}"

        db_file             "${cfg.dbFile}"

        state_file          "${cfg.dataDir}/state"
        sticker_file        "${cfg.dataDir}/sticker.sql"

        bind_to_address     "${cfg.network.listenAddress}"
        port                "${toString cfg.network.port}"
        ${cfg.extraConfig}
      '';
    in
    mkIf cfg.enable {
      systemd = {
        services.mpd = {
          description = "Music Player Daemon";
          after = [
            "network.target"
            "sound.target"
          ];
          wantedBy = mkIf (!cfg.network.startWhenNeeded) [ "default.target" ];
          path = [
            cfg.package
            pkgs.dash
            pkgs.toybox
          ];
          script = "mpd --no-daemon ${mpdConf}";
          preStart = ''dash -c "mkdir -p '${cfg.dataDir}' '${cfg.playlistDirectory}'"'';
        };
        sockets.mpd = mkIf cfg.network.startWhenNeeded {
          listenStreams = [
            "${cfg.network.listenAddress}:${toString cfg.network.port}"
            "%t/mpd/socket"
          ];
          socketConfig = {
            KeepAlive = true;
            Backlog = 5;
          };
          wantedBy = [ "sockets.target" ];
        };
      };
    };
}
