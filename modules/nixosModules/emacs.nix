{
  enable = false;
  edit = { self, pkgs, ... }: {
    services.emacs = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.emacs;
    };
  };
}
