# Enable CUPS to print documents.
# Enable sane for scanner.
{
  enable = true;
  hosts = [ "laptop" ];
  config =
    { meta, pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [
          # just so you know, I still didn't manage to use my mf3010 printer
          pkgs.canon-cups-ufr2
          pkgs.gutenprint
        ];
      };
      hardware.sane.enable = true;
      environment.shellAliases = {
        scan = "scanimage -d pixma:04A92759_0149U0000342 --resolution 600 --format=pdf -o";
      };

      users.users."${meta.user}".extraGroups = [
        "scanner"
        "lp"
      ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/cups" ];
    };
}
