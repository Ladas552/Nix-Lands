{
  hosts = [ "server" ];
  config =
    { pkgs, ... }:
    {
      # module
      services.qbittorrent = {
        enable = true;
        webuiPort = 8081;
        torrentingPort = 53243;
        serverConfig = {
          Preferences = {
            WebUI = {
              AlternativeUIEnabled = true;
              RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
              Username = "admin";
              # generated with:
              # nix run 'git+https://codeberg.org/feathecutie/qbittorrent_password' -- -p password
              Password_PBKDF2 = "QQ1LEvyRba5oZavWfTJXkA==:sd8pTQ0S8MNpqt0AJfsiv0ja0+sTFukpHVAv0D4PzDuNVP62zyNW5uXpbekmp3tgbT0xBBGvK6c/B0kLt3++eQ==";
              AuthSubnetWhitelist = "100.74.112.27";
              AuthSubnetWhitelistEnabled = true;
              LocalHostAuth = false;
            };
            Downloads.SavePath = "/srv/media/Downloads";
            Connection.GlobalUPLimit = 200;
          };
          BitTorrent.Session = {
            GlobalMaxRatio = 2;
            GlobalUPSpeedLimit = 200;
            MaxActiveDownloads = 1;
            MaxActiveTorrents = 4;
            UseCategoryPathsInManualMode = true;
            DisableAutoTMMByDefault = false;
          };

        };
        extraArgs = [
          "--confirm-legal-notice"
        ];
      };
      users.users."qbittorrent".extraGroups = [ "media" ];

      networking.firewall.allowedTCPPorts = [
        53243
      ];
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8081 ];

      #  IF GPT is right, it allows for torrents to download in readable state, But I am not sure, and I will check it later. But it just works now. 8th of August 2025
      systemd.services.qbittorrent.serviceConfig.UMask = "002"; # Sets UMask for the qbittorrent service
      # another GPT thing to set categories path declarativly
      systemd.tmpfiles.settings."10-qbt-categories"."/var/lib/qBittorrent/qBittorrent/config/categories.json"."C+" =
        {
          user = "qbittorrent";
          group = "qbittorrent";
          mode = "0755";
          argument = toString (
            pkgs.writeText "categories.json" (
              builtins.toJSON {
                # music
                music_anime.save_path = "/srv/media/Music/Anime";
                music_games.save_path = "/srv/media/Music/Games";
                music_normal.save_path = "/srv/media/Music/IRLPeople";
                # video
                anime.save_path = "/srv/media/Videos/Anime";
                movies.save_path = "/srv/media/Videos/Movies";
                tv.save_path = "/srv/media/Videos/TV";
                # miscellaneous
                books.save_path = "/srv/media/Books/unsorted";
              }
            )
          );
        };

      # Reverse proxy
      services.caddy.virtualHosts."qbittorrent.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:8081
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/qBittorrent" ];
    };
}
