# hosts without gui also need kitty because of term-info package, I know, stupid
{
  hosts = [
    "pc"
    "laptop"
    "vps"
    "server"
  ];
  config = { self, pkgs, ... }: {
    environment = {
      systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty ];
      shellAliases = {
        kssh = "kitten ssh"; # for kitty terminal
      };
    };
  };
}
