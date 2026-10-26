{
  hosts = [ "vps" ];
  config = {
    services = {
      nginx = {
        enable = true;
        streamConfig = ''
          server {
            listen 6161;
            proxy_pass 100.74.112.27:6161;
          }
        '';
      };

      caddy.virtualHosts = {
        "matrix.ladas552.me".extraConfig = ''
          reverse_proxy /_matrix/* http://127.0.0.1:6161
        '';
        "ladas552.me".extraConfig = ''
          header /.well-known/matrix/* Content-Type application/json
          header /.well-known/matrix/* Access-Control-Allow-Origin *

          respond /.well-known/matrix/server `{
              "m.server": "matrix.ladas552.me:443"
          }`
          respond /.well-known/matrix/client `{
              "m.homeserver": {
                  "base_url": "https://matrix.ladas552.me"
              },
              "m.identity_server": {
                  "base_url": "https://matrix.org"
              },
              "org.matrix.msc3575.proxy": {
                  "url": "https://matrix.ladas552.me"
              }
          }`
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [
      443
      6161
    ];
  };
}
