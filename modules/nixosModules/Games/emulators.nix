{
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        raze
        # vkquake
        # Emulators
        blastem
        mgba
        # snes9x-gtk
        # https://github.com/NixOS/nixpkgs/issues/461665
        # punes
        melonds
        # doesn't work       retroarchFull
        # too complex and need a special controller      mame
      ];
      # persist emulators
      custom.imp.home = {
        directories = [
          "Games"
          "id1"
          ".vkquake"
          ".snes9x"
          ".config/mgba"
          ".config/puNES"
          ".config/raze"
          ".local/share/blastem"
          ".local/share/puNES"
        ];
      };
    };
}
