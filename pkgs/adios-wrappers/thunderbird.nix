# this module doesn't exist in adios-wrappers.
# but I reuse the firefox module as thunderbird module with injects
_: {
  options = {
    package.defaultFunc = { inputs }: inputs.nixpkgs.pkgs.thunderbird-latest-unwrapped;
    policies.default.Preferences = {
      app.donation.eoy.version.viewed = 999;
      browser.aboutConfig.showWarning = false;
      browser.ping-centre.telemetry = false;
      datareporting.healthreport.uploadEnabled = false;
      datareporting.policy.dataSubmissionEnabled = false;
      datareporting.policy.dataSubmissionPolicyBypassNotification = true;
      extensions.getAddons.showPane = false;
      extensions.htmlaboutaddons.recommendations.enabled = false;
      # disabling this breaks google account
      javascript.enabled = true;
      # javascript.options.wasm= false;
      mail.chat.enabled = false;
      privacy.resistFingerprinting = true;
      security.warn_entering_weak = true;
      security.warn_leaving_secure = true;
      security.warn_viewing_mixed = true;
      toolkit.coverage.opt-out = true;
      toolkit.telemetry.archive.enabled = false;
      toolkit.telemetry.bhrPing.enabled = false;
      toolkit.telemetry.coverage.opt-out = true;
      toolkit.telemetry.firstShutdownPing.enabled = false;
      toolkit.telemetry.newProfilePing.enabled = false;
      toolkit.telemetry.shutdownPingSender.enabled = false;
      toolkit.telemetry.unified = false;
      toolkit.telemetry.updatePing.enabled = false;
      # prefferences
      ## start week on monday
      calendar.week.start = 1;
      ## no sound
      calendar.alarms.playsound = false;
      mail.biff.play_sound = false;
    };
  };
}
