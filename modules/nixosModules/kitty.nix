{
  hosts = [ "laptop" "vps" "server"];
  config = { self, pkgs, ... }: {
    environment = {
      systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty ];
      shellAliases = {
        kssh = "kitten ssh"; # for kitty terminal
      };
    };
  };
}
