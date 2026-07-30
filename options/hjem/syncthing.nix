{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.services.syncthing;
in
{
  options.services.syncthing = {
    enable = mkEnableOption "syncthing";

    package = mkPackageOption pkgs "syncthing" { };

  };

  config = mkIf cfg.enable {
    systemd.services.syncthing = {
      description = "Syncthing - Open Source Continuous File Synchronization";
      after = [ "network.target" ];
      path = [ cfg.package ];
      script = "syncthing serve --no-browser --no-restart --no-upgrade --gui-address=127.0.0.1:8384";
      serviceConfig = {
        Restart = "on-failure";
        SuccessExitStatus = [
          3
          4
        ];
        RestartForceExitStatus = [
          3
          4
        ];

        # Sandboxing.
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateUsers = true;
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service";
      };
      wantedBy = [ "default.target" ];
    };

  };
}
