{
  enable = false;
  edit =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.clang-tools ];
    };
}
