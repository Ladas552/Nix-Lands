{
  # run ollama chat on my most powerful gpu, which is on my pc, rx6700xt
  enable = false;
  hosts = [ "pc" ];
  config = {
    services.open-webui = {
      enable = true;
      port = 1212;
      host = "0.0.0.0";
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        # assumes ollama runs locally
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };

    # Reverse proxy
    services.caddy.virtualHosts."llm.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:1212
      '';
    };

    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 1212 ];

    # persist for Impermanence
    custom.imp.root.cache.directories = [ "/var/lib/open-webui" ];
  };
}
