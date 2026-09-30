# hosts without gui also need kitty because of term-info package, I know, stupid
{
  hosts = [
    "pc"
    "laptop"
    "vps"
    "server"
    "iso"
  ];
  config = { wrappers, ... }: {
    environment = {
      systemPackages = [ wrappers.kitty.drv ];
      shellAliases = {
        kssh = "kitten ssh"; # for kitty terminal
      };
    };
  };
}
