{
  hosts = [
    "pc"
    "laptop"
  ];
  config = { wrappers, ... }: {
    environment.systemPackages = [
      wrappers.firefox.drv
    ];
    environment.sessionVariables.BROWSER = "firefox";

    # persist for impermanence
    custom.imp.home.cache.directories = [
      # All the extensions/settings are in the wrapper, but cookies and history still will be in these
      ".config/mozilla/firefox"
      ".cache/mozilla/firefox"
    ];
  };
}
