{ self, pkgs, ... }:
let
  sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
  src = sources.canary.src;
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "canary";
  version = "unstable-2022-6-29";
  inherit src;
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
