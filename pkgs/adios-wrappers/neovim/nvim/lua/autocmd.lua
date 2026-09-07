local au = vim.api.nvim_create_autocmd
local aug = function(group_name, clear)
    clear = vim.F.if_nil(clear, true)
    return vim.api.nvim_create_augroup(group_name, { clear = clear })
end
-- Highligt yanked/pasted text
au("TextYankPost", {
  callback = function()
    vim.hl.hl_op({ higroup = "Visual", timeout = 300 })
  end,
})

-- follow relative path when switching file
au("BufEnter", {
  command = "silent! lcd %:p:h",
})

-- Preserve last editing position
au("BufReadPost", {
    group = aug("last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exists
au("BufWritePre", {
    group = aug("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        -- TODO: confirm to create parent directories
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- quickly exit help pages
au("FileType", {
  pattern = { "help", "checkhealth", "notify" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true })
  end,
})

-- disable search highligt when entering command line
au("CmdlineEnter", {
    group = aug("auto_hlsearch"),
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
})

-- strip trailing whitespace on save
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

-- better looking special buffers
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
