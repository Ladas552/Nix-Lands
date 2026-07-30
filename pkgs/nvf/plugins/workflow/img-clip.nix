{
  vim = {
    utility.images.img-clip.enable = true;
    keymaps = [
      # Img-clip.nvim
      {
        action = "<cmd>PasteImage<CR>";
        key = "<leader>p";
        mode = "n";
        desc = "Paste image";
      }
    ];
  };
}
