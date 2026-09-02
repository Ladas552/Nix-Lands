{
  hosts = [ "server" ];
  config =
    { pkgs, inputs, ... }:
    let
      # https://docs.papermc.io/paper/aikars-flags/
      jvmOpts = "-Xms6G -Xmx6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
    in
    {
      # module
      imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
      nixpkgs.overlays = [
        inputs.nix-minecraft.overlay
      ];

      services.minecraft-servers = {
        enable = true;
        eula = true;
        servers.paper = {
          enable = true;
          package = pkgs.paperServers.paper-1_21_11;
          autoStart = true;
          enableReload = true;
          inherit jvmOpts;
          symlinks = {
            # skins for offline mode
            "plugins/SkinsRestorer.jar" = pkgs.fetchurl {
              url = "https://hangarcdn.papermc.io/plugins/SRTeam/SkinsRestorer/versions/15.11.0/PAPER/SkinsRestorer.jar";
              hash = "sha256-CHDE4oEvb7Z07GXMbK3LctZK/GCeCmFm9yy1BOL9T+A=";
            };
            # Proximity chat
            "plugins/PlasmoVoice-Paper-2.1.8.jar" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/1bZhdhsH/versions/SKgeYMeH/PlasmoVoice-Paper-2.1.8.jar";
              hash = "sha256-ZtRhxsvkEGBJzUtRV+bqO91RgRzIFge1aOjh97rTPZ8=";
            };
            # preload chunks with a command
            "plugins/Chunky-Bukkit-1.4.40.jar" = pkgs.fetchurl {
              url = "https://hangarcdn.papermc.io/plugins/pop4959/Chunky/versions/1.4.40/PAPER/Chunky-Bukkit-1.4.40.jar";
              hash = "sha256-KlR3/ID3EBLhWt4c402+uDbhdiOyjbESSSwPFEPAlyE=";
            };
            # Save items after death
            "plugins/AxGraves-1.26.2.jar" = pkgs.fetchurl {
              url = "https://hangarcdn.papermc.io/plugins/Artillex-Studios/AxGraves/versions/1.26.2/PAPER/AxGraves-1.26.2.jar";
              hash = "sha256-w6qfCukLy2fdAmllCCcrCZW4Aw/bMM2Nyrl7DSsQt58=";
            };
            # Leaves cleaner
            "plugins/RHLeafDecay-Paper-1.21_R3.jar" = pkgs.fetchurl {
              url = "https://hangarcdn.papermc.io/plugins/X0R3/RHLeafDecay/versions/1.21_R3/PAPER/RHLeafDecay-Paper-1.21_R3.jar";
              hash = "sha256-TgpYqJGEIm11rBJMBRgnWlHKgAs3vDnuqEP9DAntdgY=";
            };
            # Auth to kill off bots
            "plugins/AuthMe-5.7.0-FORK-Universal.jar" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/3IEZ9vol/versions/oezVemzR/AuthMe-5.7.0-FORK-Universal.jar";
              hash = "sha256-C/uW2T8LZZeR303yuYuV3C1twashF4fw8byXpgTWEi4=";
            };
            # Sleep with just 1 player
            "plugins/Sleeper-1.10.5.jar" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Kt3eUOUy/versions/The62i8h/Sleeper-1.10.5.jar";
              hash = "sha256-wG0fQxRZRRSjJrR7StqLElGbQ51ig/mN2gob+qBc5Vw=";
            };
          };
          serverProperties = {
            accepts-transfers = false;
            allow-flight = false;
            broadcast-console-to-ops = true;
            broadcast-rcon-to-ops = false;
            difficulty = "hard";
            enable-code-of-conduct = false;
            enable-jmx-monitoring = false;
            enable-query = false;
            enable-rcon = true;
            # please don't hack me
            "rcon.password" = "password";
            enable-status = true;
            enforce-secure-profile = false;
            enforce-whitelist = false;
            entity-broadcast-range-percentage = 100;
            force-gamemode = false;
            function-permission-level = 2;
            gamemode = "survival";
            generate-structures = true;
            hardcore = false;
            hide-online-players = false;
            initial-enabled-packs = "vanilla";
            level-name = "world";
            log-ips = true;
            max-chained-neighbor-updates = 1000000;
            max-players = 20;
            max-tick-time = 60000;
            max-world-size = 29999984;
            motd = "Boyz server: No backups, no keepInventory, Hard";
            network-compression-threshold = 256;
            online-mode = false;
            op-permission-level = 4;
            pause-when-empty-seconds = 60;
            player-idle-timeout = 0;
            prevent-proxy-connections = false;
            rate-limit = 0;
            region-file-compression = "deflate";
            server-port = "25565";
            simulation-distance = 10;
            spawn-protection = 16;
            status-heartbeat-interval = 0;
            sync-chunk-writes = true;
            use-native-transport = true;
            view-distance = 12;
            white-list = false;
          };
        };
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 25565 ];
      networking.firewall.interfaces.tailscale0.allowedUDPPorts = [ 25565 ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/srv/minecraft" ];
    };
}
