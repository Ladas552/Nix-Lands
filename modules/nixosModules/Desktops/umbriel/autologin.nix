{
  hosts = [
    "pc"
    "iso"
  ];
  config =
    { meta, ... }:
    {
      # Autologin
      services.displayManager.autoLogin.enable = true;
      services.displayManager.autoLogin.user = "${meta.user}";
      services.greetd = {
        enable = true;
        settings = rec {
          # initial session for autologin
          # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
          initial_session = {
            command = "sh -c 'systemctl --user import-environment; exec systemctl --user start --wait umbriel.service'";
            user = "${meta.user}";
          };
          default_session = initial_session;
        };
      };
    };
}
