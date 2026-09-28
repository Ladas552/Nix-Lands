# bootstrap adios modules
{
  pkgs,
  adios,
  adios-wrappers,
  self,
}:
let
  root = {
    modules = adios.lib.inject [
      (adios-wrappers // { thunderbird = adios-wrappers.firefox; })
      # https://github.com/llakala/adios-wrappers/blob/main/docs/guide.md#what-is-adioslibimportmodules
      (adios.lib.importModules { directory = ./adios-wrappers; })
    ];
  };

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
      "/self" = {
        inherit self;
      };
    };
  };
in
# call each wrapper with empty args to get its output
# it differs from vanilla, so just package is `drv` while changing package in the module is { }
builtins.mapAttrs (_: module: module // { drv = module { }; }) tree.modules
