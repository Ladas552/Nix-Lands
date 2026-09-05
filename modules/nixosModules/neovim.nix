{
  hosts = [
    "pc"
    "server"
    "wsl"
    "laptop"
    "iso"
  ];
  config =
    {
      self,
      pkgs,
      meta,
      ...
    }:
    {
      environment = {
        systemPackages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.neovim
          pkgs.lua51Packages.lua
          pkgs.lua51Packages.luarocks
          pkgs.gnumake
          pkgs.tree-sitter
          pkgs.unzip
        ];
        sessionVariables.EDITOR = "nvim";

        shellAliases = {
          vn = "nvim ${meta.configPath}/pkgs/adios-wrappers/neovim/nvim";
        };
      };
    };
}
