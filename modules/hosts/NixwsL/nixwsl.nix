{
  hosts = [ "wsl" ];
  config =
    {
      meta,
      pkgs,
      lib,
      inputs,
      self,
      ...
    }:
    {
      imports = [
        inputs.nixos-wsl.nixosModules.wsl
      ];
      _module.args = {
        meta = {
          hostname = "NixwsL";
          configPath = "/home/ladas552/Projects/Nix-Lands";
          user = "ladas552";
        };
      };

      # Standalone Packages
      environment.systemPackages = with pkgs; [
        self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate
        typst
      ];

      # Environmental Variables
      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
      };

      # WSL isn't good with switch for some reason
      environment.shellAliases = { } // {
        yy = lib.mkForce "nh os boot ${meta.configPath}";
        yyy = lib.mkForce "nh os boot -u ${meta.configPath}";
      };

      wsl = {
        enable = true;
        defaultUser = "${meta.user}";
        startMenuLaunchers = true;
        tarball.configPath = "${meta.configPath}";
        usbip.enable = true;
        useWindowsDriver = true;
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.05"; # Did you read the comment?

      nixpkgs.hostPlatform = "x86_64-linux";
    };
}
