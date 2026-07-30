{
  hosts = [ "server" ];
  config =
    { lib, pkgs, ... }:
    {
      services.karakeep = {
        enable = true;
        browser.exe = "${lib.getExe' pkgs.ungoogled-chromium "chromium"}";
        extraEnvironment = {
          PORT = "9221";
          DISABLE_SIGNUPS = "true";
          OCR_LANGS = "eng,rus";
          INFERENCE_ENABLE_AUTO_TAGGING = "false";
        };
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
        9222
        9221
      ];

      # Reverse proxy
      services.caddy.virtualHosts."karakeep.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:9221
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/karakeep"
        "/var/cache/karakeep"
        "/var/lib/meilisearch"
      ];
    };
}
