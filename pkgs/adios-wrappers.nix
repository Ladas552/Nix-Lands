# bootstrap adios modules
{
  pkgs,
  adios,
  adios-wrappers,
}:
let
  root = {
    modules = adios.lib.inject [
      adios-wrappers
      # https://github.com/llakala/adios-wrappers/blob/main/docs/guide.md#what-is-adioslibimportmodules
      (adios.lib.importModules { directory = ./adios-wrappers; })
    ];
  };

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
    };
  };
in
# call each wrapper with empty args to get its output
builtins.mapAttrs (_: module: module { }) tree.modules
