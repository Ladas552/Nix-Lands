{ pkgs, ... }:
{
  vim.extraPlugins = {
    "auto-save".package = pkgs.vimPlugins.auto-save-nvim;
    "auto-save".setup = # lua
      "require('auto-save').setup{}";
  };
}
