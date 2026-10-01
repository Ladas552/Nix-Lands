{
  enable = false;
  hosts = [ "laptop" ];
  config = {
    hj.rum.programs.foot = {
      enable = true;
      # Need to make a systemD service for foot client
      settings = {
        main.shell = "fish";
        main.font = "monospace:size=13";
        bell.system = "no";
        cursor = {
          blink = "yes";
          style = "beam";
          beam-thickness = 0.5;
        };
        key-bindings = {
          scrollback-up-half-page = "Shift+Control+Up";
          scrollback-down-half-page = "Shift+Control+Down";
          font-increase = "Shift+Control+equal";
          font-decrease = "Shift+Control+minus";
          font-reset = "Shift+Control+BackSpace";
          quit = "Shift+Control+w";
        };
        colors = {
          selection-foreground = "1E1F28";
          selection-background = "44475A";
          background = "181B28";
          foreground = "F8F8F2";
          urls = "0087BD";
          regular0 = "000000"; # black
          regular1 = "ff5555"; # red
          regular2 = "50fa7b"; # green
          regular3 = "da00e9"; # highligh
          regular4 = "bd92f8"; # blue
          regular5 = "ff78c5"; # magenta
          regular6 = "8ae9fc"; # cyan
          regular7 = "bbbbbb"; # white
          bright0 = "545454"; # br black
          bright1 = "ff5454"; # br red
          bright2 = "50fa7b"; # br green
          bright3 = "f0fa8b"; # br yellow
          bright4 = "bd92f8"; # br blue
          bright5 = "ff78c5"; # br magenta
          bright6 = "8ae9fc"; # br cyan
          bright7 = "ffffff"; # br white
        };
      };
    };
  };
}
