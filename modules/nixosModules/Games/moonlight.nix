{
  pocket =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.moonlight-qt ];
    };
}
