# Quick git alias
# gcp "your commit" to push new commit
{ pkgs, lib, ... }:
pkgs.writeShellScriptBin "gcp" # bash
  ''
    ${lib.meta.getExe' pkgs.gitMinimal "git"} add --all && ${lib.meta.getExe' pkgs.gitMinimal "git"} commit -m "$1" && ${lib.meta.getExe' pkgs.gitMinimal "git"} push
  ''
