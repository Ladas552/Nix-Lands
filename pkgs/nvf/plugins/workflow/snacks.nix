{ pkgs, ... }:
{
  vim = {
    extraPackages = [ pkgs.sqlite ];
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile.enabled = true;
        image = {
          enabled = true;
          doc.inline = false;
          doc.float = true;
          convert.notify = false;
          # only make it load on specific file types
          langs = [
            "markdown"
            "typst"
            "norg"
          ];
        };
        picker.enabled = true;
      };
    };
    keymaps = [
      {
        action = "<cmd>lua Snacks.picker.recent()<CR>";
        key = "<leader>fr";
        mode = "n";
        desc = "Recent files";
      }
      {
        action = "<cmd>lua Snacks.picker.files()<CR>";
        key = "<leader>ff";
        mode = "n";
        desc = "Find Files";
      }
      {
        action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
        key = "<leader>d";
        mode = "n";
        desc = "Show diagnostics";
      }
      {
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        key = "<leader>fs";
        mode = "n";
        desc = "Rip-grep";
      }
      {
        action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
        key = "<leader>fc";
        mode = "n";
        desc = "Grep openned buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        key = "<leader>b";
        mode = "n";
        desc = "List buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.lsp_config()<CR>";
        key = "<leader>fl";
        mode = "n";
        desc = "Show LSP config";
      }
      {
        action = "<cmd>lua Snacks.picker.help()<CR>";
        key = "<f1>";
        mode = "n";
        desc = ":h";
      }
      {
        action = "<cmd>lua Snacks.picker.undo()<CR>";
        key = "<leader>fu";
        mode = "n";
        desc = "Undo history";
      }
      {
        action = "<cmd>lua Snacks.picker.icons()<CR>";
        key = "<leader>fi";
        mode = "n";
        desc = "Icon browser";
      }
      {
        action = "<cmd>lua Snacks.picker.highlights()<CR>";
        key = "<leader>fh";
        mode = "n";
        desc = "Highlight list";
      }
      {
        action = "<cmd>lua Snacks.picker.pick()<CR>";
        key = "<leader>fp";
        mode = "n";
        desc = "Picker picker";
      }
      {
        action = "<cmd>lua Snacks.picker.command_history()<CR>";
        key = "<leader>f?";
        mode = "n";
        desc = "Command history";
      }
      {
        action = "<cmd>lua Snacks.picker.spelling()<CR>";
        key = "z=";
        mode = "n";
        desc = "Spelling list";
      }
    ];
  };
}
