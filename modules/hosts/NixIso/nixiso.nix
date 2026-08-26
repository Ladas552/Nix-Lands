# build the image with
# nixos-rebuild build-image --image-variant iso --flake "github:Ladas552/Nix-Lands#NixIso"
{
  hosts = [ "iso" ];
  config =
    {
      modulesPath,
      lib,
      pkgs,
      self,
      meta,
      ...
    }:
    let
      qalc = self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate;
    in
    {
      imports = [
        # base for iso
        (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
      ];
      _module.args = {
        meta = {
          hostname = "NixIso";
          configPath = "~/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        ungoogled-chromium
        wl-clipboard
        qalc
        wget
        lshw
        telegram-desktop
        xarchiver
        gparted
        # Get list of locales
        glibcLocales
      ];

      environment = {
        shellAliases = {
          wget-install = "${lib.getExe' pkgs.wget "wget"} https://raw.githubusercontent.com/Ladas552/Nix-Lands/refs/heads/master/docs/zfs.norg";
          wget-impermanence = "${lib.getExe' pkgs.wget "wget"} https://raw.githubusercontent.com/Ladas552/Nix-Lands/refs/heads/master/docs/impermanence.norg";
          git-install = "${lib.getExe' pkgs.git "git"} clone https://github.com/Ladas552/Nix-Lands.git";
        };
      };

      # Environmental Variables
      environment.variables = {
        BROWSER = "ungoogled-chromium";
      };

      nixpkgs.hostPlatform = "x86_64-linux";
      # SSH into an iso
      services.openssh.settings = {
        PermitRootLogin = lib.mkForce "yes";
        PasswordAuthentication = lib.mkForce true;
      };

      # Enable networking
      networking.networkmanager.enable = true;
      networking.wireless.enable = lib.mkForce false;

      # Seg faults the iso build
      # i18n.supportedLocales = lib.mkForce [ "all" ];

      # graphics
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.getty.autologinUser = lib.mkForce "${meta.user}";
      users.users."${meta.user}".hashedPasswordFile = lib.mkForce null;

      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
