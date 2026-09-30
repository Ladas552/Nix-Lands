{
  enable = false;
  hosts = [ "laptop" ];
  config = { wrappers, ... }: {
    services.emacs = {
      enable = true;
      package = wrappers.emacs;
    };
  };
}
