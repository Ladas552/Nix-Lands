_: {
  inputs.self.from = { parent }: parent.self;
  options = {
    initLuaContents.default = ''
      require("init")
    '';

    devPlugins.default = [ ./nvim ];

    extraPackages.defaultFunc = { inputs }: with inputs.nixpkgs.pkgs;
      [
        tinymist
        nixd
      ];

    startPlugins.defaultFunc =
      { inputs }:
      let
        sources = inputs.nixpkgs.pkgs.callPackage "${inputs.self.self}/_sources/generated.nix" { };
        canola = inputs.nixpkgs.pkgs.vimUtils.buildVimPlugin {
          name = "canola";
          src = sources.canola.src;
        };
      in
      {
        inherit (inputs.nixpkgs.pkgs.vimPlugins) neogit img-clip-nvim;
        inherit canola;
      };

    treesitterPackage.defaultFunc =
      { inputs }: inputs.nixpkgs.pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  };
}
