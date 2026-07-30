{
  hosts = [ "laptop" ];
  config = {
    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "canary,kz";
      xkb.variant = "";
      xkb.options = "grp:caps_toggle";
      xkb.model = "pc105";
    };
  };
}
