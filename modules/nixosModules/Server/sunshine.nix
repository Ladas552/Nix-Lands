{
  # This module suppousetly works, but my nvidia gpu doesn't work with it. The Software rendering works tho
  enable = false;
  hosts = [ "server" ];
  config =
    { meta, ... }:
    {
      services.sunshine = {
        enable = true;
        openFirewall = true;
        capSysAdmin = true;
      };
      # stolen from https://github.com/ap-1/nixcfg/blob/3c4fd18c58388d2954295e0f5466964e3ac4fb23/modules/pc/sunshine.nix
      # Discovery
      services.avahi = {
        enable = true;
        nssmdns4 = true; # allows system to resolve .local addresses
        publish = {
          enable = true;
          userServices = true; # broadcasts sunshine
          addresses = true; # broadcasts this machine's IP
        };
      };

      # Input configuration
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
      # Virtual display
      # https://discourse.nixos.org/t/nixos-sunshine-setup-using-a-virtual-screen/64857/4
      boot.kernelParams = [ "video=eDP-1:1920x1080R@60D" ];

      # hardware.display.edid.packages = [
      #   (pkgs.runCommand "edid-custom" { } ''
      #                       mkdir -p $out/lib/firmware/edid
      #                       base64 -d > "$out/lib/firmware/edid/custom1.bin" <<'EOF'
      #     EDID content
      #           EOF
      #   '')
      # ];
      # hardware.display.outputs."HDMI-A-1".edid = "custom1.bin";

    };
}
