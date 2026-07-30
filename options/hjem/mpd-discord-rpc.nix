{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  toml = pkgs.formats.toml { };
  cfg = config.services.mpd-discord-rpc;
in
{
  options.services.mpd-discord-rpc = {
    settings = mkOption {
      type = toml.type;
      default = { };
      example = {
        hosts = [ "localhost:6600" ];
        format = {
          details = "$title";
          state = "On $album by $artist";
        };
      };
      description = ''
        Configuration included in `config.toml`.
        For available options see <https://github.com/JakeStanger/mpd-discord-rpc#configuration>
      '';
    };
    enable = mkEnableOption "mpd-discord-rpc";
    package = mkPackageOption pkgs "mpd-discord-rpc" { };
  };
  config = mkIf cfg.enable {
    xdg.config.files."discord-rpc/config.toml".source = toml.generate "config.toml" cfg.settings;
    systemd.services.mpd-discord-rpc = {
      wantedBy = [ "default.target" ];
      description = "Discord Rich Presence for MPD";
      documentation = [ "https://github.com/JakeStanger/mpd-discord-rpc" ];
      path = [ cfg.package ];
      script = "mpd-discord-rpc";
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
