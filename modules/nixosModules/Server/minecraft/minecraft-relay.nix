{
  hosts = [ "vps" ];
  config = {
    services.nginx = {
      enable = true;
      streamConfig = ''
        server {
          listen 25565;
          proxy_pass 100.74.112.27:25565;
        }
        server {
          listen 25565 udp;
          proxy_pass 100.74.112.27:25565;
          proxy_timeout 15s;
        }
      '';
    };
    # Reverse proxy
    services.caddy.virtualHosts."minecraft.ladas552.me" = {
      extraConfig = ''
        handle {
          reverse_proxy http://127.0.0.1:25565
        }
      '';
    };
  };
}
