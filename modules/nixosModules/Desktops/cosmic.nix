{
  enable = false;
  hosts = [ "laptop" ];
  config = {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # persist for Impermanence
    custom.imp = {
      home.cache.directories = [
        ".config/cosmic"
        ".local/state/cosmic"
      ];
      home.cache.files = [ ".config/cosmic-initial-setup-done" ];
    };
  };
}
