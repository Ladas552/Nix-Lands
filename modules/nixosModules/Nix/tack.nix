{
  hosts = [
    "pc"
    "laptop"
    "server"
  ];
  config =
    {
      inputs,
      pkgs,
      config,
      meta,
      ...
    }:
    {
      programs.tack = {
        enable = true;
        package = (
          inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack.overrideAttrs { doCheck = false; }
        );
        nixConfTokens = true;
      };
      secrets."github_token" = {
        neededForUsers = true;
        owner = meta.user;
        mode = "4444";
      };
      environment.variables.GITHUB_TOKEN = "$(cat ${config.secrets."github_token".path})";
    };
}
