{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config = {
    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "us,kz";
      xkb.variant = "";
      xkb.options = "grp:caps_toggle";
      xkb.model = "pc105";
    };
  };
}
