{ promise, ... }: {
  options = {
    nativeMessagingHosts.default = promise (
      { inputs }:
      with inputs.nixpkgs.pkgs;
      [
        keepassxc
        ff2mpv
        # gst_all_1.gstreamer
      ]
    );

    policies.default = {
      ManagedBookmarks = import ./bookmarks.nix;
      # stolen from @heisfer
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      PopupBlocking = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      SearchEngines = import ./searchEngines.nix;
      ExtensionSettings = import ./extension.nix;
      Preferences = import ./preferences.nix;
    };
  };
}
