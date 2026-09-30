{
  hosts = [
    "pc"
    "laptop"
  ];
  config =
    { pkgs, wrappers, ... }:
    {
      environment.systemPackages = [
        pkgs.ff2mpv
        wrappers.mpv.drv
      ];
    };
}
