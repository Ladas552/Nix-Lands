{

  enable = false;
  hosts = [ "laptop" ];
  config = {
    services.desktopManager.budgie.enable = true;
  };
}
