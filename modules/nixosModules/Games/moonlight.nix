{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.moonlight-qt ];
    };
}
