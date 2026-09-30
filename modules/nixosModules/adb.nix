{
  enable = false;
  workstation =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.android-tools ];
    };
}
