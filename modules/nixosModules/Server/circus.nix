{
  hosts = [ "server" ];
  config =
    { inputs, config, ... }:
    {
      # CI to build my config and packages, tasks set in webui
      # config stolen from @rysieko at https://tangled.org/did:plc:r6znfbtinv4yhwfpuxdsdvgn
      imports = [ inputs.circus.nixosModules.default ];
      services.circus = {
        enable = true;
        server.enable = true;
        evaluator.enable = true;
        queueRunner.enable = true;
        settings = {
          declarative.api_keys = [
            # ability to login
            {
              name = "circus-admin";
              key_file = "${config.secrets.circus-api.path}";
              role = "admin";
            }
          ];
          # if circus fails to start, add user and database manually to postgresql
          database.url = "postgresql:///circus?host=/run/postgresql&user=circus";
          server = {
            host = "127.0.0.1";
            port = 3001;
            force_secure_cookies = true;
            rate_limit_rps = 100;
            rate_limit_burst = 20;
          };
          evaluator = {
            poll_interval = 300;
            restrict_eval = true;
          };
          gc = {
            enabled = true;
            max_age_days = 7;
          };
          # can be accessed via ncro or ncps
          cache = {
            enabled = true;
            cache_url = "https://circus.ladas552.me/nix-cache/";
          };
          signing = {
            enabled = true;
            key_file = "${config.secrets.circus.path}";
            public_key = "circus.ladas552.me-1:Zs4de2JNShhtJhjJTorpuEb+CLjth/xn8e9uNM1XBy4=";
          };
          ui = {
            brand_name = "Ladas552";
            brand_subtitle = "The Biggest Clown";
          };
          # declare repos and jobs to build, can be done from webui too
          declarative.projects = [
            {
              name = "Nix-Lands";
              repository_url = "https://tangled.org/ladas552.me/Nix-Lands";
              cache_enabled = true;
              cache_url = "https://ci.example.org/projects/Nix-Lands/nix-cache/";
              jobsets = [
                {
                  name = "NixPort";
                  nix_expression = ".#nixosConfigurations.NixPort.config.system.build.toplevel";
                  only_build_latest = true;
                }
                {
                  name = "NixOSu";
                  nix_expression = ".#nixosConfigurations.NixOSu.config.system.build.toplevel";
                  only_build_latest = true;
                }
                {
                  name = "NixBox";
                  nix_expression = ".#nixosConfigurations.NixBox.config.system.build.toplevel";
                  only_build_latest = true;
                }
              ];
            }
          ];
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."circus.ladas552.me" = {
        useACMEHost = "ladas552.me";
        extraConfig = ''
          reverse_proxy localhost:3001
        '';
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 3001 ];

      # secrets
      secrets."circus".owner = "circus";
      secrets."circus-api".owner = "circus";

      # persist for Impermanence
      system.nixos-core.persistence.stores."/cache".directories = [
        {
          target = "/var/lib/circus";
          owner = "circus";
          group = "circus";
        }
        {
          target = "/var/lib/circus-server";
          owner = "circus-server";
          group = "circus-server";
        }
        {
          target = "/var/lib/circus-evaluator";
          owner = "circus-evaluator";
          group = "circus-evaluator";
        }
      ];
    };
}
