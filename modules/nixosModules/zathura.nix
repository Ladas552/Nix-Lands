{
  gui = { pkgs, self, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zathura.drv ];
    custom.imp.home.cache.directories = [
      ".local/share/zathura"
    ];
  };
}
