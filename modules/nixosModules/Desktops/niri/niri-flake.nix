{
  hosts = [ "laptop" "iso" ];
  config =
    {
      inputs,
      pkgs,
      config,
      meta,
      ...
    }:

    {
      imports = [
        inputs.niri.nixosModules.default
      ];

      # To use master branch niri without building rust
      # nix.settings = {
      #   extra-substituters = [
      #     "https://niri-nix.cachix.org"
      #   ];
      #   extra-trusted-public-keys = [
      #     "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
      #   ];
      # };
      # nixpkgs.overlays = [ inputs.niri.overlays.niri-nix ];
      # Niri using flake
      # uncomment the niri inputs in flake.nix to use this
      programs.niri = {
        enable = true;
        useNautilus = false;
        # package = pkgs.niri-unstable;
        # I use my own portal settings
        withXDG = false;
      };

      environment.systemPackages = with pkgs; [
        # inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
        xwayland-satellite
        brightnessctl
        wl-clipboard
        # xfce4-power-manager
        # self.packages.${pkgs.stdenv.hostPlatform.system}.rofi-powermenu
        # self.packages.${pkgs.stdenv.hostPlatform.system}.wpick
      ];

      environment.variables = {
        DISPLAY = ":0";

        NIXOS_OZONE_WL = "1";

        ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        config = {
          niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
          niri.default = "gnome";
          common.default = "gnome";
          obs.default = "gnome";
        };
      };

      # Autologin
      services.displayManager.autoLogin.enable = true;
      services.displayManager.autoLogin.user = "${meta.user}";
      services.greetd = {
        enable = true;
        settings = rec {
          # initial session for autologin
          # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
          initial_session = {
            command = "niri-session";
            user = "${meta.user}";
          };
          default_session = initial_session;
        };
      };
      # set options for niri
      hj = {
        niri.settings = import ./_niri-config.nix { };
        # finalConfig line exists in the open, and not in the option file, because option file is under hjem scope, which doesn't have access to `inputs` arg. And I am too lazy to inherit it in hjem module scope.
        niri.finalConfig =
          (inputs.niri.lib.mkNiriKDL config.hj.niri.settings) + "\n" + config.hj.niri.extraConfig;

        xdg.config.files."niri/config.kdl".text = config.hj.niri.finalConfig;
      };
    };
}
