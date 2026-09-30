{ pkgs, sources, ... }:
let
  # nvfetcher pins
  cyrillic = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.cyrillic) src pname version;
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
