{
  edit = { inputs, pkgs, ... }: {
    programs.tack = {
      enable = true;
      package = inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack;
      nixConfTokens = false;
    };
  };
}
