{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { meta, ... }:
    {
      hj.rum.programs.neovide = {
        enable = true;
        settings = {
          vsync = false;
          srgb = true;
          wsl = meta.hostname == "NixwsL";
          font = {
            size = 13;
            normal = "JetBrainsMono Nerd Font Mono";
          };
        };
      };
    };
}
