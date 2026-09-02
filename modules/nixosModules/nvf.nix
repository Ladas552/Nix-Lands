{
  hosts = [
    "pc"
    "server"
    "wsl"
    "laptop"
    "iso"
  ];
  config = { self, pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvf ];
    environment.sessionVariables.EDITOR = "nvim";
  };
}
