{
  hosts = ["pc" "laptop" ];
  config = { pkgs, self, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.zathura ];
    custom.imp.home.cache.directories = [
      ".local/share/zathura"
    ];
  };
}
