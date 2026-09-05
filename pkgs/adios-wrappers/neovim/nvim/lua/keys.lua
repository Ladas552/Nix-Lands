local kbd = vim.keymap.set

kbd("n", "<C-z>", "<Nop>")     -- don't accidentally suspend
kbd("n", ";", ":")             -- fast command-line mode
kbd("n", "<esc>", "<cmd>nohlsearch<cr>")

kbd("n", "<C-c>", "norm gcc<CR>")
kbd("v", "<C-c>", "norm gc<CR>")

kbd("v", ">", ">gv")
kbd("v", "<", "<gv")

kbd("n", "<S-u>", "<cmd>redo<cr>")

kbd("t", "<esc>", "<C-\\><C-n>")

kbd("n", "<S-Left>", "<C-w>h")
kbd("n", "<S-Down>", "<C-w>j")
kbd("n", "<S-Up>", "<C-w>k")
kbd("n", "<S-Right>", "<C-w>l")

kbd("n", "<A-Up>", "<cmd>resize +2<cr>")
kbd("n", "<A-Down>", "<cmd>resize -2<cr>")
kbd("n", "<A-Left>", "<cmd>vertical resize +2<cr>")
kbd("n", "<A-Right>", "<cmd>vertical resize -2<cr>")

kbd("n", "<leader>ts", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spelling" })

kbd("n", "<leader>r", "<cmd>restart<cr>")
