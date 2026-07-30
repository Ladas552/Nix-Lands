{ inputs, pkgs, ... }:
let
  adios = import "${inputs.adios}/adios";

  # Nixpkgs module
  nixpkgsModule = adios: {
    name = "nixpkgs";
    options = {
      pkgs = {
        type = adios.types.attrs;
      };
      lib = {
        type = adios.types.attrs;
        defaultFunc = { options }: options.pkgs.lib;
      };
    };
  };

  # Create tree by calling adios with root module definition then options
  tree =
    adios
      {
        name = "root";
        modules = {
          nixpkgs = nixpkgsModule adios;
          wrapAdifox = import "${inputs.adifox}/wrapAdifox.nix" adios;
        };
      }
      {
        options = {
          "/nixpkgs" = { inherit pkgs; };
        };
      };

  thunderbird = tree.modules.wrapAdifox {
    package = pkgs.thunderbird-latest-unwrapped;
    extraPrefs = # js
      ''
        pref("app.donation.eoy.version.viewed", 999);
        pref("browser.aboutConfig.showWarning", false);
        pref("browser.ping-centre.telemetry", false);
        pref("datareporting.healthreport.uploadEnabled", false);
        pref("datareporting.policy.dataSubmissionEnabled", false);
        pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true);
        pref("extensions.getAddons.showPane", false);
        pref("extensions.htmlaboutaddons.recommendations.enabled", false);
        // disabling this breaks google account
        pref("javascript.enabled", true);
        // pref("javascript.options.wasm", false);
        pref("mail.chat.enabled", false);
        pref("privacy.resistFingerprinting", true);
        pref("security.warn_entering_weak", true);
        pref("security.warn_leaving_secure", true);
        pref("security.warn_viewing_mixed", true);
        pref("toolkit.coverage.opt-out", true);
        pref("toolkit.telemetry.archive.enabled", false);
        pref("toolkit.telemetry.bhrPing.enabled", false);
        pref("toolkit.telemetry.coverage.opt-out", true);
        pref("toolkit.telemetry.firstShutdownPing.enabled", false);
        pref("toolkit.telemetry.newProfilePing.enabled", false);
        pref("toolkit.telemetry.shutdownPingSender.enabled", false);
        pref("toolkit.telemetry.unified", false);
        pref("toolkit.telemetry.updatePing.enabled", false);
        // prefferences
        /// start week on monday
        pref("calendar.week.start", 1);
        /// no sound
        pref("calendar.alarms.playsound", false);
        pref("mail.biff.play_sound", false);
      '';
  };

in

thunderbird
