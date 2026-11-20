{ promise, types, ... }:
{
  inputs = {
    mkWrapper.from = { parent }: parent.mkWrapper;
    nixpkgs.from = { parent }: parent.nixpkgs;
  };

  options = {
    configFile = {
      type = types.pathLike;
      default = ./config;
      description = "";
    };
    environment = {
      type = types.attrs;
      default = {
        XKB_DEFAULT_LAYOUT = "canary,kz";
        XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
        NIXOS_OZONE_WL = "1";
        ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
      };
      description = "env";
    };

    package = {
      type = types.derivation;
      default = promise ({ inputs }: inputs.nixpkgs.pkgs.cagebreak);
      description = "The Cagebreak package to be wrapped.";
    };
  };

  inputs.mkWrapper.options = promise (
    { options }:
    {
      inherit (options) package environment;
      symlinks = {
        "$out/cagebreak/config" = if options ? configFile then options.configFile else { };
      };
      flags = [
        "-c"
        "$out/cagebreak/config"
      ];
    }
  );

  result = promise ({ results }: results.mkWrapper);

}
