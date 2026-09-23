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
      # stolen from https://github.com/ap-1/nixcfg/blob/3c4fd18c58388d2954295e0f5466964e3ac4fb23/modules/pc/sunshine.nix
      # Discovery, doesn't really work, I connect using tailscale
      services.avahi = {
        enable = true;
        nssmdns4 = true; # allows system to resolve .local addresses
        publish = {
          enable = true;
          userServices = true; # broadcasts sunshine
          addresses = true; # broadcasts this machine's IP
        };
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
