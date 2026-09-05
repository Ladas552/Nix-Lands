-- wrapper is just a symlink, so to have modular config, I prepend the actual config path
vim.opt.rtp:prepend(vim.fn.expand("~/Projects/my_repos/Nix-Lands/pkgs/adios-wrappers/neovim/nvim"))
-- modules in lua directory for modular config
require("ui")
require("keys")
require("autocmd")
require("completion")
require("lsp")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable unused built-in plugins (matches upstream config's intent)
local disabled_builtins = {
  "netrwPlugin", "tarPlugin", "zipPlugin", "gzip", "tar", "zip",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "rrhelper",
}
for _, name in ipairs(disabled_builtins) do
  vim.g["loaded_" .. name] = 1
end

-- Disable providers we don't use (perl/node/ruby not needed for a plugin-free setup)
for _, provider in ipairs({ "perl", "node", "ruby" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.c_syntax_for_h = true

-- Slightly faster Lua module resolution
vim.loader.enable()

-- Options

local opt = vim.opt

opt.hidden = true
opt.updatetime = 50
opt.timeoutlen = 500
opt.ttimeoutlen = 5
opt.shortmess:append("filnxtToOFatsc")
opt.inccommand = "split"
opt.path = "**"
opt.isfname:append("@-@")
opt.backspace = "indent,eol,start"
opt.mouse = "a"
opt.swapfile = false
opt.undofile = true

-- Folding via built-in Tree-sitter
-- Falls back to manual folding on filetypes without a parser.
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Buffer / editing
opt.breakindent = true
opt.linebreak = true
opt.wrap = true
opt.smartcase = true
opt.ignorecase = true
opt.copyindent = true
opt.smartindent = true
opt.preserveindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.conceallevel = 2
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.virtualedit = "block"
opt.spelllang = "en_us"
opt.spelloptions = "camel,noplainbuffer"
opt.spellsuggest = "best,6"
