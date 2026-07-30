{ pkgs, ... }:
let
  # plugins
  kakouneWithPlugins = pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [
      parinfer-rust
      kakoune-lsp
      kakoune-catppuccin
    ];
  };
  # add binaries to PATH
  kakouneDeps = pkgs.symlinkJoin {
    name = "kakoune-deps";
    paths = with pkgs; [
      kakoune-lsp
      kak-tree-sitter
      nixd
      nixfmt
    ];
  };

  # wrap kakoune config into a derivation
  kakouneWrapped = pkgs.symlinkJoin {
    name = "kak";
    paths = [ kakouneWithPlugins ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      mkdir $out/kak
      ln -s ${./kakrc.kak} $out/kak/kakrc
      wrapProgram $out/bin/kak \
      --prefix PATH : ${kakouneDeps}/bin \
      --set XDG_CONFIG_HOME $out
    '';
  };
in
kakouneWrapped
