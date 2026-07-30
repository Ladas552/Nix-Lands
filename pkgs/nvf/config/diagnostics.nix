{ lib, ... }:
{
  # Config for diagnostics with lsp
  vim.diagnostics.enable = true;
  vim.diagnostics.config =
    let
      sy = "vim.diagnostic.severity";
      raw = lib.generators.mkLuaInline;
    in
    {
      underline = {
        enable = true;
        severity.min = raw "${sy}.WARN";
      };
      virtual_lines = {
        enable = true;
        current_line = true;
      };
      virtual_text = false;
      update_in_insert = true;
      severity_sort = true;
      float = {
        source = "if_many";
        border = "rounded";
        show_header = false;
      };
      signs = {
        severity.min = raw "${sy}.HINT";
        text = raw ''
          {
          [${sy}.ERROR] = "",
          [${sy}.WARN] = "",
          [${sy}.INFO] = "",
          [${sy}.HINT] = "",
          }
        '';
        "numhl" = raw ''
          {
          [${sy}.ERROR] = "DiagnosticSignError",
          [${sy}.WARN] = "DiagnosticSignWarn",
          [${sy}.INFO] = "DiagnosticSignInfo",
          [${sy}.HINT] = "DiagnosticSignHint",
          }
        '';
      };
    };
}
