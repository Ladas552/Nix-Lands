{
  vim = {
    utility.oil-nvim = {
      enable = true;
      setupOpts = {
        # i don't have trash
        delete_to_trash = false;
        view_options.show_hidden = true;
      };
    };
    keymaps = [
      # Oil
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>e";
        mode = "n";
      }
    ];
  };
}
