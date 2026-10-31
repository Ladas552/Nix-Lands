{
  hosts = [
    "laptop"
    "pc"
  ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.R
        pkgs.rstudio
      ];
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".config/RStudio"
        ".config/rstudio"
        ".local/share/rstudio"
      ];
    };
}
