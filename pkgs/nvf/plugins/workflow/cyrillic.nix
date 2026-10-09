{ pkgs, inputs, ... }:
let
  cyrillic = pkgs.vimUtils.buildVimPlugin {
    name = "cyrillic";
    src = inputs.cyrillic;
  };
in
{
  vim.extraPlugins = {
    "cyrillic".package = cyrillic;
    "cyrillic".setup = # lua
      ''
        require('cyrillic').setup{
          no_cyrillic_abbrev = true,
        }
      '';
  };
}
