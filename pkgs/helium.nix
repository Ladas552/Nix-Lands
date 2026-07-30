# stolen from weegs710
# https://github.com/weegs710/AnomalOS/blob/f23a7019a53a8952d253d43defb1281712dccdbd/modules/shareables/wrapped-helium.nix
{
  pkgs,
  self,
  ...
}:
let

  source = (pkgs.callPackage "${self}/_sources/generated.nix" { }).helium;

  extensionPolicy = pkgs.writeText "policy.json" (
    builtins.toJSON {
      # IDs only (no URLs) to avoid triggering TRK protocol blocking
      ExtensionInstallForcelist = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "odibgflepadohfmpcemnjbhkionjkapk" # Helium Translator Inline
      ];
    }
  );

  policiesDir = pkgs.runCommand "helium-policies" { } ''
    mkdir -p $out/etc/opt/chrome/policies/managed
    cp ${extensionPolicy} $out/etc/opt/chrome/policies/managed/extensions.json
  '';

  widevineConfig = pkgs.writeText "latest-component-updated-widevine-cdm" (
    builtins.toJSON {
      Path = "${pkgs.widevine-cdm}/share/google/chrome/WidevineCdm";
    }
  );

  # Tarball allows more control than AppImage
  heliumPkg = pkgs.stdenv.mkDerivation rec {
    inherit (source) pname version src;

    nativeBuildInputs = with pkgs; [
      makeWrapper
      autoPatchelfHook
    ];

    buildInputs = with pkgs; [
      stdenv.cc.cc.lib
      gtk3
      nss
      nspr
      alsa-lib
      cups
      libdrm
      mesa
      expat
      libxkbcommon
      pango
      cairo
      at-spi2-atk
      at-spi2-core
      dbus
      libva
      libGL
    ];

    # Qt shim libraries are optional compatibility layers
    autoPatchelfIgnoreMissingDeps = [
      "libQt5Core.so.5"
      "libQt5Gui.so.5"
      "libQt5Widgets.so.5"
      "libQt6Core.so.6"
      "libQt6Gui.so.6"
      "libQt6Widgets.so.6"
    ];

    sourceRoot = "helium-${version}-x86_64_linux";

    installPhase = ''
      mkdir -p $out/opt/helium $out/bin

      cp -r . $out/opt/helium/
      chmod +x $out/opt/helium/helium

      makeWrapper $out/opt/helium/helium $out/bin/helium \
        --add-flags "--enable-features=VaapiVideoDecoder,WebUIDarkMode,HeliumCatUi,HideCrashedBubble,LinkPreview" \
        --add-flags "--disable-features=EyeDropper,HeliumCatFixedAddressBar"

      mkdir -p $out/share/applications
      cp $out/opt/helium/helium.desktop $out/share/applications/
      substituteInPlace $out/share/applications/helium.desktop \
        --replace 'Exec=helium --incognito' 'Exec=${pname} &'

      for size in 16 32 48 64 128 256; do
        mkdir -p $out/share/icons/hicolor/''${size}x''${size}/apps
        if [ -f $out/opt/helium/product_logo_''${size}.png ]; then
          cp $out/opt/helium/product_logo_''${size}.png \
             $out/share/icons/hicolor/''${size}x''${size}/apps/helium.png
        fi
      done
    '';

    meta = {
      description = "Private, fast, and honest web browser";
      homepage = "https://helium.computer/";
      platforms = [ "x86_64-linux" ];
    };
  };

  heliumWrapper = pkgs.writeShellScript "helium-wrapper" ''
    USER_DATA_DIR=""
    for arg in "$@"; do
      if [[ "$arg" == --user-data-dir=* ]]; then
        USER_DATA_DIR="''${arg#*=}"
        break
      fi
    done

    if [ -z "$USER_DATA_DIR" ]; then
      USER_DATA_DIR="$HOME/.config/net.imput.helium"
    fi

    mkdir -p "$USER_DATA_DIR/WidevineCdm"
    cp ${widevineConfig} "$USER_DATA_DIR/WidevineCdm/latest-component-updated-widevine-cdm"

    exec ${heliumPkg}/bin/helium "$@"
  '';

  wrappedHelium = pkgs.buildFHSEnv {
    name = "helium";
    targetPkgs = pkgs: [
      heliumPkg
    ];
    extraBwrapArgs = [
      "--ro-bind ${policiesDir}/etc/opt/chrome/policies/managed /etc/chromium/policies/managed"
    ];
    runScript = heliumWrapper;
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cp ${heliumPkg}/share/applications/helium.desktop $out/share/applications/

      for size in 16 32 48 64 128 256; do
        mkdir -p $out/share/icons/hicolor/''${size}x''${size}/apps
        if [ -f ${heliumPkg}/share/icons/hicolor/''${size}x''${size}/apps/helium.png ]; then
          cp ${heliumPkg}/share/icons/hicolor/''${size}x''${size}/apps/helium.png \
             $out/share/icons/hicolor/''${size}x''${size}/apps/
        fi
      done
    '';
    meta = {
      mainProgram = "helium";
      description = "Helium browser with DRM, dark UI, and bundled extensions";
    };
  };
in
wrappedHelium
