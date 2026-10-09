{
  inputs,
  pkgs,
  ...
}:
let
  adios-wrappers = import ./adios-wrappers.nix {
    inherit pkgs inputs;
    adios = inputs.adios.adios;
    adios-wrappers = inputs.adios-wrappers.wrapperModules;
  };
in
{
  default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
  # editor wrappers
  nvf = pkgs.callPackage ./nvf { inherit inputs; };
  kakoune = pkgs.callPackage ./kakoune { };
  emacs = pkgs.callPackage ./emacs { };
  # packages
  canary = pkgs.callPackage ./canary.nix { inherit inputs; };
  # wrappers
  libqalculate = pkgs.callPackage ./qalc.nix { };
  # scripts
  gcp = pkgs.callPackage ./addcommitpush.nix { };
  eval = pkgs.callPackage ./eval-stats.nix { };
  Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
  musnow = pkgs.callPackage ./musnow.nix { };
}
// adios-wrappers
