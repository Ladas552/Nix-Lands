vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  virtual_lines = { current_line = true },
  float = { border = "single", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
