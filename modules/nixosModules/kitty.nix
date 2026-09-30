# hosts without gui also need kitty because of term-info package, I know, stupid
{
  all = { self, pkgs, ... }: {
    environment = {
      systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty.drv ];
      shellAliases = {
        kssh = "kitten ssh"; # for kitty terminal
      };
    };
  };
}
