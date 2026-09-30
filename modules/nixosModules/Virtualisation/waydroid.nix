{
  enable = false;
  virtualisation = {
    virtualisation.waydroid.enable = true;

    # persist for Impermanence
    custom.imp = {
      root.cache.directories = [ "/var/lib/waydroid" ];
      home.cache.directories = [ ".local/share/waydroid" ];
    };
  };
}
