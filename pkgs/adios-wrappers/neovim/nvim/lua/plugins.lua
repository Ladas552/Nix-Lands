-- I don't have plugin manager, because lux.nvim is not ready, but I can't live without these keybings, so I am using nix to use these plugins for now
local kbd = vim.keymap.set
require("oil").setup({
delete_to_trash = false,
view_options = {show_hidden = true },
});
kbd("n", "<leader>g", "<cmd>Neogit<cr>")
kbd("n", "<leader>e", "<cmd>Oil<cr>")
