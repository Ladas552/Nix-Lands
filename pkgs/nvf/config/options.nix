{
  vim = {
    options = {
      # general options for neovim
      #Numbers on side
      numberwidth = 1;
      #Indent
      tabstop = 2; # 2 spaces for tabs (prettier default)
      shiftwidth = 2; # 2 spaces for indent width
      expandtab = true; # expand tab to spaces
      autoindent = true; # copy indent from current line when starting new one
      copyindent = true;
      smartindent = true;
      preserveindent = true;
      #Colors
      termguicolors = true;
      background = "dark"; # colorschemes that can be light or dark will be made dark
      signcolumn = "yes"; # show sign column so that text doesn't shift
      #Backspace
      backspace = "indent,eol,start"; # allow backspace on indent, end of line or insert mode start position
      #Split windowws
      splitright = true; # split vertical window to the right
      splitbelow = true; # split horizontal window to the bottom
      #Scroll
      scrolloff = 999;
      #Update
      updatetime = 50;
      #Soft Wrap
      linebreak = true;
      breakindent = true;
      #Set cursor coloring in the terminal
      guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor";
      cursorline = true;
      cursorlineopt = "number";
      # no `~` in my numbar
      fillchars = "eob: ";
      # ui
      winborder = "single";
    };
    # nvf modules that modify native neovim options
    spellcheck = {
      enable = true;
      languages = [
        "en_us"
        "ru"
      ];
    };
    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };
    lineNumberMode = "relNumber";
    searchCase = "smart";
    syntaxHighlighting = true;
    undoFile.enable = true;
    enableLuaLoader = true;
  };
}
