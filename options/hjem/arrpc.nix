{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.services.arrpc;
in
{
  options.services.arrpc = {
    enable = mkEnableOption "arrpc";

    package = mkPackageOption pkgs "arrpc" { };
  };

  config = mkIf cfg.enable {
    systemd.services.arrpc = {
      wantedBy = [ "graphical-session.target" ];
      description = "Discord Rich Presence for browsers, and some custom clients";
      path = [ cfg.package ];
      script = "arrpc";
      serviceConfig = {
        Restart = "always";
      };
    };
  };
}
