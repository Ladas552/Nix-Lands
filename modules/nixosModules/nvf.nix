{
  enable = false;
  hosts = [
    "pc"
    "server"
    "laptop"
    "wsl"
    "iso"
  ];
  config = { self, pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvf ];
    environment.sessionVariables.EDITOR = "nvim";
  };
}
