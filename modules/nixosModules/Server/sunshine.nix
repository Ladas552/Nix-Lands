{
  # remote desktop
  hosts = [ "pc" ];
  config =
    { meta, ... }:
    {
      services.sunshine = {
        enable = true;
        openFirewall = true;
        capSysAdmin = true;
      };

      # Input configuration on wayland
      hardware.uinput.enable = true;
      services.udev.extraRules = ''
        KERNEL=="uinput", MODE="0660", GROUP="input", SYMLINK+="uinput"
      '';

      users.users.${meta.user}.extraGroups = [
        "input"
        "video"
        "render"
        "uinput"
      ];

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".config/sunshine"
      ];
    };
}
