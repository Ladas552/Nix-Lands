{ lib, ... }:
let
  # options to put directories in, persistence but shortened
  # stolen from @iynaix
  root = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Directories to persist in root filesystem";
    };
    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Files to persist in root filesystem";
    };
    cache = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Directories to persist, but not to snapshot";
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Files to persist, but not to snapshot";
      };
    };
  };
  home = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Directories to persist in home directory";
    };
    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Files to persist in home directory";
    };
    cache = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Directories to persist, but not to snapshot";
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Files to persist, but not to snapshot";
      };
    };
  };
in
{
  options.custom.imp = { inherit root home; };
}
