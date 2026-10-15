{ pkgs, tack, ... }:
let
  cyrillic = pkgs.vimUtils.buildVimPlugin {
    name = "cyrillic";
    src = tack.cyrillic;
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
