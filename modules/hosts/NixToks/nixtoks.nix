{
  # This host is archived, I am keeping it for sentimental reasons, rather than practical
  # Don't try to evaluate it, it's most probably broken
  # This was my old lenovo laptop, with m860 nvidia card, it was my primary desktop, laptop and then server for about 7 years.
  # The best gift I could ask for in my school years
  # Started playing osu in 130fps on it, started using linux on it, started home labbing on it
  # all my hate for nvidia comes from this laptop
  # all my love for linux started from this laptop
  # rest in peace, your ram and ssd will live in my next hosts to come
  enable = false;
  hosts = [ "server" ];
  config =
    {
      config,
      pkgs,
      self,
      meta,
      ...
    }:
    {
      _module.args = {
        meta = {
          hostname = "NixToks";
          configPath = "/home/ladas552/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        imagemagick
        ffmpeg
        gst_all_1.gst-libav
        self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate
        lshw
        nuspell
        python3
        typst
        rcon-cli
        nvfetcher
        sqlite
        # custom.Subtitlenator
        nvtopPackages.nvidia
      ];

      # Environmental Variables
      environment.variables = {
        EDITOR = "nvim";
      };

      sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";
      sops.age.sshKeyPaths = [
        "/home/ladas552/.ssh/NixToks"
      ];

      # Build machine for NixWool
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

      # Linux sheduler, works post 6.12
      # services.scx = {
      #   enable = true;
      #   package = pkgs.scx.rustscheds;
      # };

      # Networking
      # NixToks wifi card is dead
      networking.networkmanager.enable = false;

      # Nvidia
      # Enable OpenGL and hardware accelerated graphics drivers

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          intel-media-driver
          # Mirrors are down for the whole month. Intel should die
          # intel-ocl
          vpl-gpu-rt
        ];
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.
      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580; # my card is old, okay
        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      # Enable cuda. Needs building
      nixpkgs.config.cudaSupport = true;
      # Environmental variable for Wayland and stuff
      environment.variables = {
        __NV_PRIME_RENDER_OFFLOAD = 1;
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
      };
      # IF statement to enable vitalization for Nvidia in Docker. If Docker module is disabled it returns false, if enabled returns true
      hardware.nvidia-container-toolkit.enable = config.virtualisation.podman.enable;

      # Define a user account. Check Impermanence Module for user password
      users.users."${meta.user}".extraGroups = [ "media" ];

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?

      ## Powermanagment
      ## It disabled usb after some time of incativity, so not usable on desktop
      powerManagement.powertop.enable = true;

      ## Turn off screen and don't go to sleep
      services.logind.settings.Login = {
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitch = "ignore";
      };

      ## Stuff to make server operatable
      users.groups."media" = { };

      services.caddy = {
        enable = true;
      };
      # stolen from @notthebe https://git.notthebe.ee/notthebee/nix-config/src/commit/03166ee6ee243c675ae4fbc43d9c06ae35ba0547/modules/homelab/services/default.nix#L68-L81
      security.acme = {
        acceptTerms = true;
        defaults.email = "me@ladas552.me";
        certs."ladas552.me" = {
          reloadServices = [ "caddy.service" ];
          domain = "ladas552.me";
          extraDomainNames = [ "*.ladas552.me" ];
          dnsProvider = "cloudflare";
          dnsResolver = "1.1.1.1:53";
          dnsPropagationCheck = true;
          group = config.services.caddy.group;
          environmentFile = config.sops.templates."cloudflare-creds".path;
        };
      };
      # secrets
      sops.secrets."mystuff/cf-api" = { };
      sops.secrets."mystuff/cf-email" = { };
      sops.templates."cloudflare-creds".content = ''
        CF_DNS_API_TOKEN="${config.sops.placeholder."mystuff/cf-api"}"
        CF_API_EMAIL="${config.sops.placeholder."mystuff/cf-email"}"
      '';

      # Open firewall ports
      networking.firewall.allowedTCPPorts = [
        80
        53
        443
      ];

      ##### ZFS MOUNT POINTS
      ##### Because I have additional drive for NixToks
      fileSystems."/mnt/zmedia" = {
        device = "zmedia/files";
        fsType = "zfs";
      };
      # media files for torrents and stuff on main drive
      fileSystems."/srv/media" = {
        device = "zroot/media";
        fsType = "zfs";
      };
    };

}
