{
  # cagebreak
  # doesn't really work with display managers, but you can launch it from tty with `cagebreak` and it works fine
  enable = false;
  hosts = [ "laptop" ];
  config =
    # init cagebreak session
    { pkgs, self, ... }:
    {
      environment.systemPackages = with pkgs; [
        # clibboard
        wl-clipboard
        # launcher
        fuzzel
        # screenshot
        wayfreeze
        slurp
        grim
        killall
        # harware keys
        brightnessctl
        pamixer
        # the config is in pkgs/adios-wrappers/cagebreak/config
        self.packages.${pkgs.stdenv.hostPlatform.system}.cagebreak.drv
      ];
    };
}
