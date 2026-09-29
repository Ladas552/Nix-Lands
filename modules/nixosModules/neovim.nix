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
      inputs,
      pkgs,
      meta,
      ...
    }:
    {
      environment = {
        systemPackages = [
          (self.packages.${pkgs.stdenv.hostPlatform.system}.neovim {
            package = inputs.nvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
            devPlugins =
              if (meta.hostname == "NixOSu" || meta.hostname == "NixPort") then
                [ "${meta.configPath}/modules/adios-wrappers/neovim/nvim" ]
              else
                [ ];
          })
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
