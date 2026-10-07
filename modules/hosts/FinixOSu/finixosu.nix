{
  config,
  modules,
  lib,
  pkgs,
  ...
}:

{
  _module.args = {
    meta = {
      hostname = "FinixOSu";
      configPath = "/persist/home/ladas552/Projects/my_repos/Nix-Lands";
      user = "ladas552";
    };
  };
  imports = with modules; [
    # WARN: Check out the comments in this file too.

    nix-daemon
    openssh
    sysklogd
    limine
    sudo
    polkit
    # WARN: Either import and enable this or any login manager, if you don't you
    # will be left with an unbootable generation.
    getty
    bash
    dhcpcd
    iwd
    labwc
    greetd
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    limine = {
      enable = true;
      settings.editor_enabled = true; # NOTE: Disable on systems that need security.
    };

    sudo.enable = true;

    bash.enable = true;

    # TODO: Pick a DE/WC.
    labwc.enable = true;
  };

  services = {
    nix-daemon = {
      enable = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };

    polkit.enable = true;

    sysklogd.enable = true;

    dbus.enable = true;

    mdevd.enable = true;

    # WARN: Are you sure you don't want to enable this? You'll have to configure
    # stuff like DNS manually to be able to access the internet.
    dhcpcd.enable = true;
    iwd.enable = true;

    # WARN: You need a seat.
    seatd.enable = true;

    # WARN: getty is not enabled by default.
    getty.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet}";
        };
      };
    };
  };

  # TODO: Define hostname.
  networking.hostName = "<HOSTNAME>";

  # TODO: Set timezone.
  time.timeZone = "<TIMEZONE>";

  # TODO: Define your user. Create a password with:
  # $ mkpasswd --method=yescrypt
  users.users."<USERNAME>" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
      config.services.seatd.group
    ];
    # WARN: Don't forget to set a hashed password here or you'll face the consequences
    # of your actions.
    password = "<HASHED_PASSWORD>";
    packages = with pkgs; [ ];
  };

  hardware.graphics.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    iputils
    iproute2
    # TODO: Pick a wayland terminal.
    kitty
    # NOTE: You can get rid of this if you use nh but be aware you need either of
    # them to rebuild your system...
    nh
  ];
}
