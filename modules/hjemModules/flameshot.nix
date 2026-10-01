{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        flameshot
        # stolen from @saygo
        # https://github.com/saygo-png/nixos/blob/e79fee2df375ef29bfabd98434c61efe6407a84a/modules/flameshot.nix#L21C1-L33C7
        (pkgs.writeShellApplication {
          name = "flameshot-ocr";
          runtimeInputs = with pkgs; [
            flameshot
            (tesseract.override {
              enableLanguages = [
                "eng"
                "rus"
              ];
            })
          ];
          text = ''
            message=$(flameshot gui -r -s | tesseract --psm 12 --oem 1 -l eng+rus stdin stdout)
            echo "$message" | wl-copy
          '';
        })

      ];
      hj.rum.programs.flameshot = {
        enable = true;
        settings = {
          General = {
            showHelp = false;
            showDesktopNotification = false;
            # make flameshot work on Niri
            useGrimAdapter = true;
          };
        };
      };
    };
}
