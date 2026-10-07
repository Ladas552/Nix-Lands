{promise,...}: {
  inputs.self.from = { parent }: parent.self;
  options = {
    initLuaContents.default = ''
      require("init")
    '';

    devPlugins.default = [ ./nvim ];

    extraPackages.default = promise( { inputs }: with inputs.nixpkgs.pkgs;
      [
        # tinymist
        nixd
      ]);

    startPlugins.default = promise (
      { inputs }:
      let
        sources = inputs.nixpkgs.pkgs.callPackage "${inputs.self.self}/_sources/generated.nix" { };
        canola = inputs.nixpkgs.pkgs.vimUtils.buildVimPlugin {
          inherit (sources.canola) src pname version;
        };
      in
      {
        inherit (inputs.nixpkgs.pkgs.vimPlugins) neogit img-clip-nvim;
        inherit canola;
      });

    treesitterPackage.default = promise (
      { inputs }: inputs.nixpkgs.pkgs.vimPlugins.nvim-treesitter.withAllGrammars);
  };
}
