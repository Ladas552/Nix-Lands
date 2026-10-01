{
  enable = false;
  hosts = [
    "laptop"
    "server"
    "vps"
  ];
  config =
    { config, ... }:
    {
      # secrets
      secrets."zero_net_id".neededForUsers = true;

      secrets."zero_net_nixtoks".neededForUsers = true;

      # module
      services.zerotierone = {
        enable = true;
        joinNetworks = [
          "$(cat ${config.secrets."zero_net_id".path})"
        ];
        localConf = {
          settings = {
            softwareUpdate = "disable";
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 9993 ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/zerotier-one" ];
    };
}
