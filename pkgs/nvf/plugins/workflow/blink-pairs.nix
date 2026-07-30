{ pkgs, ... }:
{
  vim.extraPlugins = {
    "blink-pairs".package = pkgs.vimPlugins.blink-pairs;
    "blink-pairs".setup = # lua
      ''
        require('blink.pairs').setup{
          highlights = {
            enabled = false,
          },
        }
      '';
  };
}
