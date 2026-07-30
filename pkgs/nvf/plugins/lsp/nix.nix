{
  lib,
  pkgs,
  ...
}:
{
  vim = {
    languages.nix = {
      enable = true;
      format.enable = false; # It's annoying when a repo uses Alejandro instead
      format.type = [ "nixfmt" ];
      lsp.servers = [ "nixd" ];
      treesitter.enable = true;
    };
    lsp.servers."nixd" = {
      # neovim trows  an error with semantic tokens
      cmd = lib.mkForce [
        "${lib.getExe' pkgs.nixd "nixd"}"
        "--semantic-tokens=false"
      ];
      settings.nixpkgs.expr = "import <nixpkgs> { }";
    };
  };
}
