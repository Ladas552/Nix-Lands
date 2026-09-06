local kbd = vim.keymap.set

kbd("n", "<C-z>", "<Nop>")     -- don't accidentally suspend
kbd("n", ";", ":")             -- fast command-line mode
kbd("n", "<esc>", "<C-l>", {remap = true}) -- clear buffer from cursors
kbd({ "n", "x" }, "<Space>", "<Nop>") -- leader doesn't move cursor
kbd("n", "<C-S-w>", "<cmd>qa!<cr>") -- quit with the same command as kitty

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

-- Open the CWD
kbd("n", "<leader>e", "<cmd>edit .<CR>", { desc = "Open directory explorer" })

-- Open the directory of the current file
kbd("n", "<leader>E", function()
  vim.cmd.edit(vim.fn.expand("%:p:h"))
end, { desc = "Open current file's directory" })

-- open parent directory in nvim.dir
vim.api.nvim_create_autocmd("FileType", {
  pattern = "directory",
  callback = function(ev)
    kbd("n", "<leader>e", "<cmd>edit ..<CR>", { buffer = ev.buf })
  end,
})

-- navigate buffers
kbd("n", "<leader>,", "<cmd>bprevious<cr>")
kbd("n", "<leader>.", "<cmd>bnext<cr>")
kbd("n", "<leader>x", "<cmd>bdelete<cr>")
