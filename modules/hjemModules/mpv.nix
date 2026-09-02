{
  hosts = ["pc" "laptop" ];
  config =
    { pkgs, self, ... }:
    {
      environment.systemPackages = [
        pkgs.ff2mpv
        self.packages.${pkgs.stdenv.hostPlatform.system}.mpv

      ];
    };
}
