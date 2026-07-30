{
  # Makes nh promt password twice on rebuilds
  config = {
    # Stolen from @Gerg
    # https://github.com/Gerg-L/nixos/blob/96b7bbdb20bdfbeb9d7d733cee47eaac39cf5ec0/nixosModules/security.nix
    environment.shellAliases = {
      #make run0 use aliases
      sudo = "run0 --background=''";
    };
    services.dbus.implementation = "broker";
    security = {
      sudo.enable = false;
      polkit = {
        enable = true;
        settings.Polkitd.ExpirationSeconds = 60;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            if (action.id == "org.freedesktop.policykit.exec"
                || action.id.indexOf("org.freedesktop.systemd1.") == 0) {
              return polkit.Result.AUTH_ADMIN_KEEP;
            }
          });
        '';
      };
    };
  };
}
