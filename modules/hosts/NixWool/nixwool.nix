{
  hosts = [ "vps" ];
  config =
    {
      pkgs,
      lib,
      meta,
      self,
      ...
    }:
    {
      _module.args = {
        meta = {
          hostname = "NixWool";
          configPath = "git+https://tangled.org/ladas552.me/Nix-Lands?rev=";
          user = "ladas552";
        };
      };
      nix = {
        distributedBuilds = true;
        buildMachines = [
          {
            hostName = "NixToks";
            sshUser = "ladas552";
            protocol = "ssh-ng";
            systems = [
              "x86_64-linux"
              "aarch64-linux"
            ];
            maxJobs = 16;
            speedFactor = 6;
            supportedFeatures = [
              "big-parallel"
              "kvm"
              "nixos-test"
            ];
          }
        ];
      };
      # Standalone Packages
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate
      ];

      # it's a vps, it doesn't need wifi
      networking.networkmanager.enable = false;

      # Environmental Variables
      environment.variables = {
        NIX_REMOTE = "daemon";
      };

      services.sshguard.enable = true;
      # I chowned this directories `sudo chown -R ladas552:caddy /var/www`
      users.users."${meta.user}".extraGroups = [ "caddy" ];
      services.caddy = {
        enable = true;
        globalConfig = ''
          email me@ladas552.me
        '';
        virtualHosts = {
          "blog.ladas552.me" = {
            extraConfig = ''
              root * /var/www/blog
              file_server
              encode gzip
            '';
          };
          "nix.ladas552.me" = {
            # All of this below, is because I previously had another site, instead of just adding these posts to my blog site. So yeah, mistakes of the past lead to ugly present.
            extraConfig = ''
              @posts path_regexp posts ^/posts/(.*)$
              redir @posts https://blog.ladas552.me/nix/{re.posts.1} permanent
              handle {
                redir https://blog.ladas552.me/nix{uri} permanent
              }
            '';
          };
          "ladas552.me" = {
            extraConfig = ''respond "Blog: https://blog.ladas552.me Nix-Docs: https://nix.ladas552.me Git-Hosting: https://tangled.org/did:plc:6ikdlkw64mrjygj6cea62kn4 GitHub: https://github.com/Ladas552"'';
          };
        };
      };

      # No
      system.stateVersion = "26.05"; # Did you read the comment?

      #  It's a 2 vCPU server
      nix.settings = {
        cores = lib.mkForce 1;
        max-jobs = lib.mkForce 1;
      };

      # I don't have firewall enabled, firewall is managed by hetzner, but just to be sure I added these ports
      networking.firewall.allowedTCPPorts = [
        80
        443
        3000
        25565
      ];
      networking.firewall.allowedUDPPorts = [
        443
        25565
      ];

      # Only allow SSH connection with Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 22 ];

      environment.persistence."/cache".directories = [
        {
          directory = "/var/www";
          mode = "0755";
          user = "ladas552";
          group = "caddy";
        }
      ];
    };
}
