{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [
      pkgs.noctalia
      ];
      hj.xdg.config.files."noctalia/noctalia.toml".source = ./noctalia.toml;

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".local/state/noctalia"
      ];
    };
}
