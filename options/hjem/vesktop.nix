{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;

  json = pkgs.formats.json { };
  cfg = config.programs.vesktop;
in
{
  options.programs.vesktop = {
    settings = mkOption {
      type = json.type;
    };

    vencord.settings = mkOption {
      type = json.type;
    };

    enable = mkEnableOption "vesktop";

    package = mkPackageOption pkgs "vesktop" { };

  };

  config = mkIf cfg.enable {
    packages = mkIf (cfg.package != null) [ cfg.package ];

    xdg.config.files."vesktop/settings.json" = mkIf (cfg.settings != { }) {
      source = json.generate "vesktop-settings" cfg.settings;
    };

    xdg.config.files."vesktop/settings/settings.json" = mkIf (cfg.vencord.settings != { }) {
      source = json.generate "vencord-settings" cfg.vencord.settings;
    };
  };
}
