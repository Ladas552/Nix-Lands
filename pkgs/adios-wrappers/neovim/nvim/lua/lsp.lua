vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  update_in_insert = false,
  virtual_lines = { current_line = true },
  underline = { severity = { min = vim.diagnostic.severity.WARN }, },
  float = { border = "single", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
      [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
    },
  },
})
