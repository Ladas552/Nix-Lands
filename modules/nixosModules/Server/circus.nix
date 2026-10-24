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
          # define where builds happen and remote build using github actions
          queue_runner = {
            workers = 0;
            rpc = {
              bind = "0.0.0.0:8443";
              # use certs for tls, you already have to enable and setup acme to get this certs in this location
              tls = {
                cert_file = "/var/lib/acme/ladas552.me/fullchain.pem";
                key_file = "/var/lib/acme/ladas552.me/key.pem";
                require_client_cert = false;
              };
              cache_substituter = "https://circus.ladas552.me/nix-cache";
              cache_public_key = "circus.ladas552.me-1:Zs4de2JNShhtJhjJTorpuEb+CLjth/xn8e9uNM1XBy4=";
              # so I can connect to gha runner and use workflows
              oidc = {
                issuer = "https://token.actions.githubusercontent.com";
                audiences = [ "circus-agent" ];
                allowed_repositories = [ "ladas552/circus-agent" ];
                allowed_subject_prefixes = [
                  "repo:ladas552/circus-agent:ref:refs/heads/master"
                ];
                allowed_workflow_refs = [
                  "ladas552/circus-agent/.github/workflows/circus-builder.yml@refs/heads/master"
                ];
              };
            };
            # setup gha runner
            ephemeral_pools =
              let
                pool = system: {
                  name = "gha-${system}";
                  allowed_build_repositories = [ "ladas552/circus-agent" ];
                  systems = [ "${system}" ];
                  max_inflight = 4;
                  github_actions = {
                    workflow_repository = "ladas552/circus-agent";
                    workflow = "circus-builder.yml";
                    ref_name = "master";
                    token_file = "${config.secrets.circus-agent-github.path}";
                    runner_url = "circus+tls://circus-agent.ladas552.me";
                    oidc_audience = "circus-agent";
                    agent_binary_url = "https://circus.ladas552.me/artifacts/circus-agent-${system}";
                  };
                };
              in
              map pool ["x86_64-linux" "aarch64-linux"];
          };
          # declare repos and jobs to build, can be done from webui too
          declarative.projects = [
            {
              name = "Nix-Lands";
              repository_url = "https://tangled.org/ladas552.me/Nix-Lands";
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
                {
                  name = "NixWool";
                  nix_expression = ".#nixosConfigurations.NixWool.config.system.build.toplevel";
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

      # Only allow WebUI over Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 3001 ];
      # make RPC bind for github actions
      networking.firewall.allowedTCPPorts = [ 8443 ];

      # secrets
      secrets."circus".owner = "circus";
      secrets."circus-api".owner = "circus";
      secrets."circus-agent-github".owner = "circus";

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
