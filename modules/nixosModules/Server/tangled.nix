{
  hosts = [ "vps" ];
  config =
    { config, inputs, ... }:
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
              git.object_format = "sha1";
              repo.default_branch = "master";
              atproto.plc_directory = "https://plc.directory";
              messages.fetch.motd = "You are so crazy for using this shit";
              xrpc.trusted_proxy_header = "x-forwarded-for";
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
      secrets."tangled-knot-master-key".owner = "knot";

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
