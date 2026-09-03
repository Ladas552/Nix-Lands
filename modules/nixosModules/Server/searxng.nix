{
  hosts = [ "vps" ];
  config = {
    services.searx = {
      enable = true;
      settings = {
        use_default_settings = true;
        default_doi_resolver = "sci-hub.se";
        ui = {
          query_in_title = true;
          center_alignment = true;
        };
        server = {
          port = 3038;
          bind_address = "0.0.0.0";
          public_instance = false;
          secret_key = "secrets";
        };
        enabled_plugins = [
          "Hash plugin"
          "Search on category select"
          "Tracker URL remover"
          "Hostname replace"
          "Unit converter plugin"
          "Basic Calculator"
          "Open Access DOI rewrite"
        ];
        search = {
          safe_search = 0; # 0 = None, 1 = Moderate, 2 = Strict
          formats = [
            "html"
            "json"
            "rss"
          ];
          autocomplete = "google"; # "dbpedia", "duckduckgo", "google", "startpage", "swisscows", "qwant", "wikipedia" - leave blank to turn it off by default
          default_lang = "en";
        };
        # plugin settings, thanks @NotAShelf
        hostnames = {
          replace = {
            "(.*\.)?reddit\.com$" = "old.reddit.com";
            "(.*\.)?redd\.it$" = "old.reddit.com";
          };

          remove = [
            "(.*\.)?redditmedia.com$"
            "(.*\.)?facebook.com$"
            "(.*\.)?softonic.com$"
            "(.*\.)?nixos.wiki$"
          ];
        };
        high_priority = [
          "(.*\.)?wikipedia.com$"
          "(.*\.)?reddit.com$"
          "(.*\.)?github.com$"
          "(.*\.)?nixos.org$"
          "(.*\.)?archlinux.org$"
          "(.*\.)?tftcentral.co.uk$"
        ];
      };
    };

    # Reverse proxy
    services.caddy.virtualHosts."searxng.ladas552.me" = {
      useACMEHost = "ladas552.me";
      extraConfig = ''
        reverse_proxy localhost:3038
      '';
    };

    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 3038 ];
  };
}
