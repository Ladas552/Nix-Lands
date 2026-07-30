{
  vim.autocomplete.blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;
    setupOpts = {
      cmdline.enabled = false;
      keymap.preset = "enter";
      signature = {
        enabled = true;
        window.border = "single";
      };
      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 500;
          window.border = "single";
        };
        list.selection = {
          preselect = false;
          auto_insert = true;
        };
        menu = {
          border = "single";
          # idk how to set this up
          # draw.columns = {
          # { "label",     "label_description", gap = 1 },
          # { "kind_icon", "kind" },
          # };
        };
        ghost_text.enabled = true;
        keyword.range = "full"; # can also be `full`
      };
      sources = {
        providers = {
          buffer.score_offset = -7;
        };
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };
  };
}
