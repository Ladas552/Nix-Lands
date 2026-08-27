{
  config =
    {
      pkgs,
      meta,
      lib,
      ...
    }:
    {
      # Define hostname.
      networking.hostName = "${meta.hostname}";
      # Generate machine-id declaratively. thanks https://radicle.network/nodes/iris.radicle.network/rad%3Az2kvqNajUjvwF2M22CnL5NXUThaUY/tree/modules/core/environment/machine-id.nix
      environment.etc.machine-id.text =
        lib.strings.substring 0 32 (lib.hashString "sha256" meta.hostname) + "\n";
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      # Set kernel
      boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_xanmod;
      # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

      # I am not blind yet
      services.speechd.enable = false;
      # Updates firmware directly from vendors
      services.fwupd.enable = true;
      # clear out journalctl logs
      services.journald.extraConfig = "MaxRetentionSec=14day";
      # Allow core dumps, idk why it isn't a default
      # https://github.com/curtbushko/nixos-config/blob/fa15644a47c6c937841ae2943370ad7228ed3e2e/systems/x86_64-linux/gamingrig/default.nix#L60
      systemd.coredump.enable = true;
      # Disable nano
      programs.nano.enable = false;
      # Disable X11 prompt for Git. Changes work only after Reboot for some reason
      # Here is the issue: https://github.com/NixOS/nixpkgs/issues/24311
      programs.ssh.askPassword = "";
      # something stolen from https://kokada.dev/blog/an-unordered-list-of-hidden-gems-inside-nixos/
      ## Faster wifi connection
      networking.networkmanager.wifi.backend = "iwd";
      ## Using cpu to comress RAM like swap
      zramSwap = {
        enable = true;
        algorithm = "zstd";
      };
      ## Supposedly faster dbus
      services.dbus.implementation = "broker";
      # Prevent systemd from waiting for network online
      systemd.network.wait-online.enable = false;
      boot.initrd.systemd.network.wait-online.enable = false;
      networking.dhcpcd.wait = "background";

      # Some programs ignore SIGTERM (notably "winedevice.exe") causing
      # a timeout until SIGKILL. This shortens this window.
      # thanks @saygo-png
      systemd.user.settings.Manager.DefaultTimeoutStopSec = "10s";

      # Set your time zone.
      time.timeZone = "Asia/Almaty";

      # Select internationalization properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "ru_RU.UTF-8";
        LC_IDENTIFICATION = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
        LC_NAME = "ru_RU.UTF-8";
        LC_NUMERIC = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_TELEPHONE = "ru_RU.UTF-8";
        LC_TIME = "ru_RU.UTF-8";
      };

      # fun
      boot.initrd.stage1Greeting = "MANKIND IS DEAD";
      boot.stage2Greeting = "BLOOD IS FUEL";
      system.activationScripts = {
        ultrakill = {
          text = # sh
            ''
              echo
              echo -e "\e[1;32mHELL IS FULL\e[0m"
              echo
            '';
        };
      };

      # persist for Impermanence
      custom.imp.home.cache.files = [ ".local/share/nix/repl-history" ];
    };
}
