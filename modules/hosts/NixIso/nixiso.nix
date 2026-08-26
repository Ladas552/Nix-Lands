# build the image with
# nixos-rebuild build-image --image-variant iso --flake "github:Ladas552/Nix-Lands#NixIso"
# or
# nh os build-image --image-variant iso --hostname NixIso "github:Ladas552/Nix-Lands"
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
        qalc
        wget
        lshw
        telegram-desktop
        xarchiver
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

      nixpkgs.hostPlatform = "x86_64-linux";
      # SSH into an iso
      services.openssh.settings = {
        PermitRootLogin = lib.mkForce "yes";
        PasswordAuthentication = lib.mkForce true;
      };

      # Enable networking, disable raw wpa
      networking.wireless.enable = lib.mkForce false;

      # Seg faults the iso build
      # i18n.supportedLocales = lib.mkForce [ "all" ];

      # graphics
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # autologin into user
      services.getty.autologinUser = lib.mkForce "${meta.user}";
      users.users."${meta.user}".hashedPasswordFile = lib.mkForce null;

      system.stateVersion = "26.11"; # Did you read the comment?
    };
}
