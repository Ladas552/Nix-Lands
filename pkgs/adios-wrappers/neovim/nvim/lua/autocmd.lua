local au = vim.api.nvim_create_autocmd

au("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

au("BufEnter", {
  command = "silent! lcd %:p:h",
})

au("BufReadPost", {
  callback = function()
    local mark = vim.fn.line("'\"")
    if mark > 1 and mark <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

au("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

au("FileType", {
  pattern = { "help", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true })
  end,
})

au("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.api.nvim_exec2([[keepjumps keeppatterns silent! %s/\s\+$//e]], {})
    vim.fn.winrestview(save)
  end,
})

au("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

au("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

local function disable_ui_settings()
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.foldlevel = 999
end

au({ "BufEnter", "BufWinEnter" }, {
  pattern = "man://*",
  callback = disable_ui_settings,
})

au("TermOpen", {
  pattern = "term://*",
  callback = function()
    disable_ui_settings()
    vim.cmd("startinsert!")
  end,
})
