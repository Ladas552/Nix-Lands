{
  hosts = [ "vps" ];
  config =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        # git
        # inputs.tangled.nixosModules.knot # old knot
        inputs.tangled.nixosModules.knot-rs
        # UI
        # inputs.tangled.nixosModules.appview
        # CI
        inputs.tangled.nixosModules.spindle
      ];

      # module
      services = {
        tangled = {
          knot-rs = {
            enable = true;
            openFirewall = false;
            environmentFile = config.secrets.tangled-knot-master-key.path;
            settings = {
              server = {
                hostname = "knot.ladas552.me";
                listen_addr = "0.0.0.0:3050";
                internal_listen_addr = "127.0.0.1:5444";
                admins = [ "did:plc:6ikdlkw64mrjygj6cea62kn4" ]; # @ladas552.me
                ssh_host_key_file = config.secrets.tangled-knot-ssh.path;
              };
              contact.email = "me@ladas552.me";
              git.object_format = "sha1";
              repo.default_branch = "master";
              atproto.plc_directory = "https://plc.directory";
              messages.fetch.motd = "You are so crazy for using this shit";
              homepage.path = pkgs.writeText "index.html" ''
                <h1>You do not belong here</h1>
              '';
              xrpc = {
                trusted_proxy_header = "x-forwarded-for";
                trusted_proxies = [
                  "127.0.0.1"
                  "100.85.212.58"
                  "100.107.219.63"
                  "100.119.233.79"
                ];
              };
              tls = {
                acme_enabled = true;
                acme_contact = "me@ladas552.me";
              };
            };
          };
          # My VPS is too weak for docker containers
          spindle = {
            enable = true;
            server = {
              listenAddr = "0.0.0.0:6555";
              hostname = "spindle.ladas552.me";
              owner = "did:plc:6ikdlkw64mrjygj6cea62kn4";
              maxJobCount = 1;
            };
            keyPath = config.secrets.tangled-spindle-key.path;
            contact.email = "me@ladas552.me";
            pipelines = {
              workflowTimeout = "10m";
              microvm.defaultImage = "nixos-aarch64";
            };
          };
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts = {
        "knot.ladas552.me".extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:3050
          }
        '';
        "spindle.ladas552.me".extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:6555
          }
        '';
      };

      # secrets
      secrets."tangled-knot-ssh".owner = "knot";
      secrets."tangled-knot-master-key" = { };
      secrets."tangled-spindle-key".owner = "spindle";

      # persist for Impermanence
      custom.imp.root = {
        directories = [
          "/var/lib/knot"
        ];
        cache.directories = [
          # "/var/lib/containers"
          "/var/log/spindle"
          "/var/lib/spindle"
        ];
      };
    };
}
