{
  vim.languages.typst = {
    enable = true;
    extensions.typst-preview-nvim = {
      enable = true;
      setupOpts = {
        follow_cursor = true;
        open_cmd = "firefox %s";
      };
    };
  };
}
