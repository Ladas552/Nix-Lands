{
  enable = false;
  hosts = [
    "laptop"
    "server"
  ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.clang-tools ];
    };
}
