{
  hosts = [ "server" ];
  config =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/technitium-api" = { };
      sops.templates."homepage-vars".content = ''
        HOMEPAGE_VAR_TECHNITIUM="${config.sops.placeholder."mystuff/technitium-api"}"
      '';

      # Reverse proxy
      services.caddy.virtualHosts."hub.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:8082
        '';
      };

      # modules
      services.homepage-dashboard = {
        enable = true;
        allowedHosts = "hub.ladas552.me";
        environmentFiles = [
          config.sops.templates."homepage-vars".path
        ];
        settings = { };
        widgets = [
          {
            resources = {
              cpu = true;
              cputemp = true;
              uptime = true;
              disk = "/";
              memory = true;
            };
          }
          {
            resources = {
              label = "HDD";
              disk = "/mnt/zmedia";
            };
          }
          {
            search = {
              provider = "custom";
              url = "https://searxng.ladas552.me/search?q=";
              target = "_blank";
            };
          }
        ];
        services = [
          # I should probably make this list per module, so adding and removing modules automatically modified the dashboard. But because it's a list of attribute sets, it's hard. So I do that later, maybe. Here is someone who has done it before
          # https://git.notthebe.ee/notthebee/nix-config/src/commit/925e20601015772b4c3048361c07b92b8f0d3f33/modules/homelab/services/homepage/default.nix
          {
            "Media" = [
              {
                "Jellyfin" = {
                  description = "Watch";
                  href = "https://jellyfin.ladas552.me";
                };
              }
              {
                "Gonic" = {
                  description = "My Sonic boom serivce";
                  href = "https://gonic.ladas552.me";
                };
              }
              {
                "Kavita" = {
                  description = "Books";
                  href = "https://kavita.ladas552.me";
                };
              }
              {
                "Miniflux" = {
                  description = "RSS feed";
                  href = "https://miniflux.ladas552.me";
                };
              }
            ];
          }
          {
            "Share/Download files" = [
              {
                "Copyparty" = {
                  description = "File transfere";
                  href = "https://copyparty.ladas552.me";
                };
              }
              {
                "Immich" = {
                  description = "Photos";
                  href = "https://immich.ladas552.me";
                };
              }
              {
                "Karakeep" = {
                  description = "Bookmark manager";
                  href = "https://karakeep.ladas552.me";
                };
              }
              {
                "NextCloud" = {
                  description = "Drive";
                  href = "https://nextcloud.ladas552.me";
                };
              }
              {
                "Qbittorrent" = {
                  description = "Torrents";
                  href = "https://qbittorrent.ladas552.me";
                };
              }
            ];
          }
          {
            "Services" = [
              {
                "Searxng" = {
                  description = "My search engine";
                  href = "https://searxng.ladas552.me";
                };
              }
              {
                "Technitium" = {
                  icon = "https://dns.ladas552.me/img/logo.png";
                  description = "DNS";
                  href = "https://dns.ladas552.me";
                  widget = {
                    type = "technitium";
                    url = "https://dns.ladas552.me";
                    key = "{{HOMEPAGE_VAR_TECHNITIUM}}";
                  };
                };
              }
              # {
              #   "ncps" = {
              #     description = "Proxy cache for local nixos network";
              #     href = "https://ncps.ladas552.me";
              #   };
              # }
              # {
              #   "Ollama" = {
              #     description = "AI Models";
              #     href = "https://ollama.ladas552.me";
              #   };
              # }
              # {
              #   "Open-Webui" = {
              #     description = "Chat with ollama models";
              #     href = "https://open-webui.ladas552.me";
              #   };
              # }
            ];
          }
        ];
        bookmarks = [ ];

      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8082 ];
    };
}
