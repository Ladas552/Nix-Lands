{
  enable = false;
  hosts = [ "laptop" ];
  config = { self, pkgs, ... }: {
    services.emacs = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.emacs;
    };
  };
}
