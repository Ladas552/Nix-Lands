{
  hosts = [ "laptop" ];
  config =
    {
      pkgs,
      lib,
      self,
      ...
    }:
    let
      canary = self.packages.${pkgs.stdenv.hostPlatform.system}.canary;
    in
    {
      console.useXkbConfig = true;
      services.xserver = {
        xkb = {
          layout = lib.mkForce "canary,kz";
          extraLayouts.canary = {
            symbolsFile = canary + "/share/X11/xkb/symbols/canary";
            description = "Canary keyboard layout";
            languages = [ "eng" ];
          };
        };
      };

      services.keyd = {
        enable = true;
        keyboards.default = {
          ids = [
            # Nuphy AirV3
            "19f5:1028:e1045ff3"
            "19f5:1028:bb509bf1"
            # Laptop keyboard
            "0001:0001:093d12dc"
          ];
          settings = {
            control = {
              # change https://github.com/Apsu/Canary keys when holding Ctrl
              ";" = "C-p";
              a = "C-;";
              b = "C-g";
              c = "C-a";
              d = "C-c";
              e = "C-k";
              f = "C-h";
              g = "C-v";
              h = "C-m";
              j = "C-z";
              i = "C-l";
              k = "C-t";
              l = "C-w";
              m = "C-n";
              n = "C-j";
              o = "C-i";
              p = "C-r";
              q = "C-b";
              r = "C-s";
              s = "C-d";
              t = "C-f";
              u = "C-o";
              v = "C-x";
              w = "C-q";
              x = "C-u";
              y = "C-e";
              z = "C-y";
            };
          };
        };
      };
    };
}
