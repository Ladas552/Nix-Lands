{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      services = {
        xserver = {
          desktopManager.xterm.enable = false;
          displayManager.lightdm = {
            enable = true;
            greeters.slick.enable = true;
            greeters.slick.theme.name = "Zukitre-dark";
          };
          # Numlock on start because I use numpad
          displayManager.setupCommands = ''
            ${pkgs.numlockx}/bin/numlockx on
          '';
        };
      };
    };
}
