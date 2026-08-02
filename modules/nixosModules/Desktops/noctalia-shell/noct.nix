{
  hosts = [ "laptop" ];
  config =
    { pkgs, inputs, ... }:
    let
      noct = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      environment.systemPackages = [
        noct
      ];
      # hjem.extraModules = [
      #   inputs.noctalia.hjemModules.default
      # ];

      # I don't want to build c++
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
      hj.xdg.config.files."noctalia/noctalia.toml".source = ./noctalia.toml;

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".local/state/noctalia"
      ];
    };
}
