{
  inputs,
  pkgs,
  self,
  ...
}:
let
  adios-wrappers = import ./adios-wrappers.nix {
    inherit pkgs;
    adios = inputs.adios.adios;
    adios-wrappers = inputs.adios-wrappers.wrapperModules;
  };
in
{
  default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
  # editor wrappers
  nvf = pkgs.callPackage ./nvf { inherit inputs self; };
  kakoune = pkgs.callPackage ./kakoune { };
  emacs = pkgs.callPackage ./emacs { };
  # packages
  helium = pkgs.callPackage ./helium.nix { inherit self; };
  canary = pkgs.callPackage ./canary.nix { inherit self; };
  # wrappers
  libqalculate = pkgs.callPackage ./qalc.nix { };
  # scripts
  gcp = pkgs.callPackage ./addcommitpush.nix { };
  eval = pkgs.callPackage ./eval-stats.nix { };
  word-lookup = pkgs.callPackage ./word-lookup.nix { };
  Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
  musnow = pkgs.callPackage ./musnow.nix { };
  wpick = pkgs.callPackage ./wpick.nix { };
}
// adios-wrappers
