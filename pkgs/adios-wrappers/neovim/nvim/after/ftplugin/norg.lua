local kbd = function(lhs, rhs, desc, remap)
  vim.keymap.set("n", lhs, rhs, { buffer = 0, desc = desc, remap = remap })
end
kbd("<localleader>o", "<Cmd>Neorg toc<CR>", "Neorg TOC")
kbd("<localleader>T", "<Cmd>Neorg tangle current-file<CR>", "Neorg Tangle")

