local opt = vim.opt
-- UI
opt.smoothscroll = true
opt.mousescroll = { "hor:6", "ver:1" }
opt.confirm = false
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.laststatus = 2
opt.winwidth = 40
opt.list = true
opt.winborder = "single"


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

opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"
