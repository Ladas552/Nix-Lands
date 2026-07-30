# wrapping stolen from https://github.com/nezia1/emacs-config
# @nezia1
# define emacs package for `nix run`
{ pkgs, ... }:
let
  # plugins
  emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      # Note Taking
      org # Org-mode
      zk # Zettlekasten for org
      # UI
      catppuccin-theme # colorscheme
      solaire-mode # color unreal bufferst darker
      which-key
      nyan-mode
      # Dashboard
      dashboard # new Start up buffer
      page-break-lines # pretty horizontal lines
      # Utilities
      eat # Better emacs Terminal
      magit # git client
      pretty-sha-path # shorten nix/store paths
      # Workflow
      meow

      # modes
      nix-ts-mode
      (epkgs.treesit-grammars.with-grammars (
        grammars: with grammars; [
          tree-sitter-nix
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-python
        ]
      ))
    ]
  );

  # add binaries to PATH
  emacsDeps = pkgs.symlinkJoin {
    name = "emacs-deps";
    paths = with pkgs; [
      # fonts
      jetbrains-mono
      nerd-fonts.symbols-only
      # lsp, formatters
      emacs-lsp-booster
      nixfmt
      nixd
      clang-tools
      basedpyright

      unzip
      gzip
      bzip2
      xz
      zstd
      p7zip
      gnutar

      pandoc
      # for nyan cat music
      mplayer
    ];
  };

  # wrap emacs into a derivation
  emacsWrapped = pkgs.symlinkJoin {
    name = "emacs";
    paths = [ emacsWithPackages ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
        --prefix PATH : ${emacsDeps}/bin \
        --prefix INFOPATH : $out/share/info \
        --add-flags --init-directory="${./config}"
    '';
  };
in
emacsWrapped
