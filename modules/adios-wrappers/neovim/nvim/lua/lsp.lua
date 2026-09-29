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

vim.lsp.config.nixd = {
  cmd = {
    "nixd",
    "--inlay-hints=true",
  },
  -- vim.uv.cwd() is the equivalent of `single_file_mode` in lspconfig
  ---@diagnostic disable-next-line undefined-field
  root_markers = { "flake.nix", ".git", vim.uv.cwd() },
  filetypes = { "nix" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
    },
  },
}
vim.lsp.enable("nixd")

vim.lsp.config.timymist = {
  cmd = { "tinymist" },
  root_markers = { "src.typ", ".git", vim.uv.cwd() },
  filetypes = { "typ", "typst" },
  settings = {
    exportPdf = "onType",
    outputPath = "$root/$name",
    fontPaths = "./fonts",
    formatterMode = "typstyle",
  },
}
vim.lsp.enable("timymist")
