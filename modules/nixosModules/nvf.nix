{
  enable = false;
  hosts = [
    "pc"
    "server"
    "laptop"
    "wsl"
    "iso"
  ];
  config = { wrappers, ... }: {
    environment.systemPackages = [ wrappers.nvf ];
    environment.sessionVariables.EDITOR = "nvim";
  };
}
