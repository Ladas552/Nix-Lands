# plugins to add
# - add auto-save-nvim module
# - cord.nvim
# - parinfer-rust
# - module for numb.nvim
# - module for blink-pairs
{
  pkgs,
  inputs,
  self,
  ...
}:
(inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  extraSpecialArgs = {
    # https://github.com/NotAShelf/nvf/issues/993#issuecomment-3127396900
    myself = self;
  };
  modules = [
    # neovim options
    ./config/autocmds.nix
    ./config/colorscheme.nix
    ./config/diagnostics.nix
    ./config/keymaps.nix
    ./config/options.nix
    ./config/ui2.nix
    # plugins
    ./plugins/cmp/blink-cmp.nix
    ./plugins/cmp/luasnip.nix
    ./plugins/lsp/lsp-config.nix
    ./plugins/ui/colorizer.nix
    ./plugins/ui/dashboard.nix
    ./plugins/ui/heirline.nix
    ./plugins/ui/numb.nix
    ./plugins/ui/rainbow-delimiters.nix
    ./plugins/ui/web-devicons.nix
    ./plugins/ui/which-key.nix
    ./plugins/workflow/auto-save.nix
    ./plugins/workflow/blink-pairs.nix
    ./plugins/workflow/cyrillic.nix
    ./plugins/workflow/direnv.nix
    ./plugins/workflow/img-clip.nix
    ./plugins/workflow/neogit.nix
    ./plugins/workflow/neorg.nix
    ./plugins/workflow/oil.nix
    ./plugins/workflow/snacks.nix
    ./plugins/workflow/treesitter.nix
    ./plugins/workflow/otter.nix
    ./plugins/workflow/nvim-surround.nix
    # lsp
    ./plugins/lsp/nix.nix
    ./plugins/lsp/python.nix
    ./plugins/lsp/rust.nix
    ./plugins/lsp/typst.nix
  ];
}).neovim
