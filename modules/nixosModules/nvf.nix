{
  enable = false;
  edit = { self, pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvf ];
    environment.sessionVariables.EDITOR = "nvim";
  };
}
