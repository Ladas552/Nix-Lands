{
  # homeBrew module
  hosts = [
    "pc"
    "laptop"
    "server"
  ];
  config = {
    hj.services.syncthing.enable = true;
    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".local/state/syncthing" ];
  };
}
