{ pkgs, ... }:
{
  vim.extraPlugins = {
    "numb".package = pkgs.vimPlugins.numb-nvim;
    "numb".setup = # lua
      ''
        -- peek into `:42` move
          require('numb').setup{
            show_numbers = true, -- Enable 'number' for the window while peeking
            show_cursorline = false, -- Enable 'cursorline' for the window while peeking
            hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
            number_only = true, -- Peek only when the command is only a number instead of when it starts with a number
            centered_peeking = true, -- Peeked line will be centered relative to window
          }
      '';
  };
}
