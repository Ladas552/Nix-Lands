{ self, pkgs, ... }:
let
  sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
in
pkgs.stdenvNoCC.mkDerivation {
  inherit (sources.canary)src version pname;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/X11/xkb/symbols/
    cp ./canary $out/share/X11/xkb/symbols

    mkdir -p $out/share/keymaps/i386/canary/
    gzip ./console/canary.map
    mv ./console/canary.map.gz $out/share/keymaps/i386/canary

    runHook postInstall
  '';
}
