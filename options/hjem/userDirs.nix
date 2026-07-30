{
  lib,
  config,
  ...
}:
let
  inherit (lib.types) path;
  inherit (lib.options) mkOption;

  cfg = config.xdg.userDirs;
in
{
  options.xdg.userDirs = {
    music.directory = mkOption {
      type = path;
      default = "${config.directory}/Music";
    };
    desktop.directory = mkOption {
      type = path;
      default = "${config.directory}/Desktop";
    };
    documents.directory = mkOption {
      type = path;
      default = "${config.directory}/Documents";
    };
    downloads.directory = mkOption {
      type = path;
      default = "${config.directory}/Downloads";
    };
    pictures.directory = mkOption {
      type = path;
      default = "${config.directory}/Pictures";
    };

    publicShare.directory = mkOption {
      type = path;
      default = "${config.directory}/Public";
    };
    templates.directory = mkOption {
      type = path;
      default = "${config.directory}/Templates";
    };
    videos.directory = mkOption {
      type = path;
      default = "${config.directory}/Videos";
    };
  };

  # Add later if need be, I only need this module to provide some options to other modules
  config = {

  };
}
