{
  enable = false;
  hosts = [ "laptot" ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.moonlight-qt ];
    };
}
