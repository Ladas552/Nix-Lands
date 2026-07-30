{
  lib,
  inputs,
  config,
  ...
}:
{
  # create options to merge niri config from different modules
  options.niri = {
    settings = lib.mkOption {
      type =
        with lib.types;
        let
          valueType =
            nullOr (oneOf [
              bool
              int
              float
              str
              path
              (attrsOf valueType)
              (listOf valueType)
            ])
            // {
              description = "Niri configuration value";
            };
        in
        types.submodule {
          freeformType = valueType;
        };
      default = { };
      description = ''
        KDL configuration for Niri written in Nix.
      '';
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra configuration lines to be added verbatim.
      '';
    };

    finalConfig = lib.mkOption {
      type = lib.types.lines;
      # default = (inputs.niri.lib.mkNiriKDL config.niri.settings) + "\n" + config.niri.extraConfig;
      # see comment in `niri-flake.nix to know why default is commented out`
      description = ''
        The final config applied to niri.
      '';
    };

  };
}
