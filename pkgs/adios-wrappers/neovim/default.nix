{ promise, ... }: {
  inputs.tack.from = { parent }: parent.tack;
  options = {
    initLuaContents.default = ''
      require("init")
    '';

    devPlugins.default = [ ./nvim ];

    extraLuaPackages.default = ps: [
      ps.lua-utils-nvim
      ps.pathlib-nvim
    ];

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
        norg-diagram = inputs.nixpkgs.pkgs.vimUtils.buildVimPlugin {
          src = inputs.tack.tack.norg-diagram;
          name = "norg-diagram";
        };
      in
      {
        inherit (inputs.nixpkgs.pkgs.vimPlugins)
          neogit
          img-clip-nvim
          neorg
          which-key-nvim
          nvim-nio
          ;
        inherit canola norg-diagram;
      }
    );

    treesitterPackage.default = promise (
      { inputs }: inputs.nixpkgs.pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    );
  };
}
