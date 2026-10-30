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
    custom.imp.home.cache.directories = [
      ".local/state/nvf"
      ".local/share/nvf"
    ];
  };
}
