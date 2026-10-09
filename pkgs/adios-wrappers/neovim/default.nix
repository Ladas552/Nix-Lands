{ promise, ... }: {
  inputs.tack.from = { parent }: parent.tack;
  options = {
    initLuaContents.default = ''
      require("init")
    '';

    devPlugins.default = [ ./nvim ];

    extraPackages.default = promise (
      { inputs }: with inputs.nixpkgs.pkgs;
      [
        # tinymist
        nixd
      ]
    );

    startPlugins.default = promise (
      { inputs }:
      let
        canola = inputs.nixpkgs.pkgs.vimUtils.buildVimPlugin {
          src = inputs.tack.tack.canola;
          name = "canola";
        };
      in
      {
        inherit (inputs.nixpkgs.pkgs.vimPlugins) neogit img-clip-nvim;
        inherit canola;
      }
    );

    treesitterPackage.default = promise (
      { inputs }: inputs.nixpkgs.pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    );
  };
}
