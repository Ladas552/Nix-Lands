{
  # cage environment using ghostty
  # special defined scripts and keybinds will be in there
  # scaling doesn't work btw
  enable = false;
  hosts = [ "laptop" ];
  config =
    {
      pkgs,
      lib,
      meta,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
      ];

      services.cage = {
        enable = true;
        program = "${lib.meta.getExe' pkgs.ghostty "ghostty"}";
        extraArguments = [
          "-m"
          "extend"
        ];
        user = "${meta.user}";
        environment = {
          XKB_DEFAULT_LAYOUT = "us,kz";
          XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
        };
      };
    };
}
