{
  inputs,
  pkgs,
  self,
  ...
}:
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
  firefox = pkgs.callPackage ./firefox.nix { inherit inputs; };
  thunderbird = pkgs.callPackage ./thunderbird.nix { inherit inputs; };
  fish = pkgs.callPackage ./fish.nix { };
  libqalculate = pkgs.callPackage ./qalc.nix { };
  # scripts
  gcp = pkgs.callPackage ./addcommitpush.nix { };
  eval = pkgs.callPackage ./eval-stats.nix { };
  word-lookup = pkgs.callPackage ./word-lookup.nix { };
  Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
  musnow = pkgs.callPackage ./musnow.nix { };
  wpick = pkgs.callPackage ./wpick.nix { };
}
