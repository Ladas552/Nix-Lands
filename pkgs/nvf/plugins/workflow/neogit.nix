{
  vim = {
    git.neogit = {
      enable = true;
      mappings = {
        commit = null;
        open = null;
        pull = null;
        push = null;
      };
    };
    keymaps = [
      # NeoGit
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>g";
        mode = "n";
        desc = "Open neogit";
      }
    ];
  };
}
