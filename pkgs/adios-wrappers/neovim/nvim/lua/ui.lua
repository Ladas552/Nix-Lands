local opt = vim.opt
-- UI
opt.smoothscroll = true
opt.mousescroll = { "hor:6", "ver:1" }
opt.confirm = false
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.laststatus = 3 -- Only one statusline, for better separator between horizontal splits
opt.winwidth = 40
opt.list = true
opt.winborder = "single"
opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"
opt.cursorline = true
opt.cursorlineopt = "number"

-- fillers
opt.fillchars = {
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  fold = " ",
  diff = "─",
  msgsep = "‾",
  foldsep = "│",
  foldopen = "▾",
  foldclose = "▸",
}

-- colorcheme
vim.cmd.colorscheme("catppuccin")

-- popups
opt.pumborder = "single"
opt.pummaxwidth = 40
opt.pumheight = 20

-- UI 2
require('vim._core.ui2').enable({
  enable = true,
  msg = {
  targets = {
    [""] = "msg",
    empty = "cmd",
    bufwrite = "msg",
    confirm = "cmd",
    emsg = "pager",
    echo = "msg",
    echomsg = "msg",
    echoerr = "pager",
    completion = "cmd",
    list_cmd = "pager",
    lua_error = "pager",
    lua_print = "msg",
    progress = "pager",
    rpc_error = "pager",
    quickfix = "msg",
    search_cmd = "cmd",
    search_count = "cmd",
    shell_cmd = "pager",
    shell_err = "pager",
    shell_out = "pager",
    shell_ret = "msg",
    undo = "msg",
    verbose = "pager",
    wildlist = "cmd",
    wmsg = "msg",
    typed_cmd = "cmd",
  },
},
})

opt.messagesopt.timeout = 10000
opt.messagesopt.height = 0.3

