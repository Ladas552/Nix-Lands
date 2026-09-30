_: {
  inputs.sources.from = { parent }: parent.sources;
  options = {
    initLuaContents.default = ''
      require("init")
    '';

    devPlugins.default = [ ./nvim ];

    extraPackages.defaultFunc = { inputs }: with inputs.nixpkgs.pkgs;
      [
        # tinymist
        nixd
      ];

    startPlugins.defaultFunc =
      { inputs }:
      let
        canola = inputs.nixpkgs.pkgs.vimUtils.buildVimPlugin {
        inherit (inputs.sources.sources.canola) src pname version;
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
