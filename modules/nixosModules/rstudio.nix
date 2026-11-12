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
        (pkgs.rstudioWrapper.override {
          packages = [
            pkgs.rPackages.tidyverse
          ];
        })
      ];
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        "R"
        ".config/RStudio"
        ".config/rstudio"
        ".local/share/rstudio"
      ];
    };
}
