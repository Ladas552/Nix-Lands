{
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      # stolen from saygo
      fonts = {
        fontconfig = {
          enable = true;
          defaultFonts = {
            serif = [ "JetBrainsMono Nerd Font Mono" ];
            sansSerif = [ "JetBrainsMono Nerd Font Mono" ];
            monospace = [ "JetBrainsMono Nerd Font Mono" ];
          };
          antialias = true;
          hinting = {
            enable = true;
            style = "full";
            autohint = false;
          };
          subpixel = {
            rgba = "none";
            lcdfilter = "default";
          };
        };
      };
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        pkgs.nerd-fonts.jetbrains-mono
        # Enable nerd fonts for every font
        #(lib.filter lib.isDerivation (lib.attrValues pkgs.nerd-fonts))
      ];
    };
}
