_: {
  options = {
    settings.default = {
      main = {
        prompt = "𝃚";
        fields = "filename,name,generic,categories";
        match-counter = true;
        terminal = "kitty --single-instance -e";
        tabs = 2;
        keyboard-focus = "on-demand";
      };
      border = {
        radius = 0;
        selection-radius = 0;
      };
      colors = {
        background = "24273aee";
        text = "cad3f5ff";
        message = "cad3f5ff";
        prompt = "8aadf4ff";
        placeholder = "6e738dff";
        input = "cad3f5ff";
        match = "8aadf4ff";
        selection = "363a4fff";
        selection-text = "cad3f5ff";
        selection-match = "8aadf4ff";
        counter = "a5adcbff";
        border = "8aadf4ff";
      };
    };
    logFlags.default = {
      logLevel = "none";
      noSyslog = true;
      colorize = "never";
      printTiming = true;
    };
    dmenuFlags.default = {
      noEmpty = true;
    };
  };
}
