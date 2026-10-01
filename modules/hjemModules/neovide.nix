{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { lib, meta, ... }:
    {
      hj.rum.programs.neovide = {
        enable = true;
        settings = {
          vsync = false;
          srgb = true;
          wsl = lib.mkIf (meta.hostname == "NixwsL") true;
          font = {
            size = 13;
            normal = "JetBrainsMono Nerd Font Mono";
          };
        };
      };
    };
}
