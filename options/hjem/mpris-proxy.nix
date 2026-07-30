{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.services.mpris-proxy;
in
{
  options.services.mpris-proxy = {
    enable = mkEnableOption "mpris-proxy";

    package = mkPackageOption pkgs "bluez" { nullable = true; };
  };
  config = mkIf cfg.enable {
    systemd.services.mpris-proxy = {
      description = "Proxy forwarding Bluetooth MIDI controls via MPRIS2 to control media players";
      bindsTo = [ "bluetooth.target" ];
      after = [ "bluetooth.target" ];
      wantedBy = [ "bluetooth.target" ];
      path = [ cfg.package ];
      script = "mpris-proxy";
    };
  };
}
