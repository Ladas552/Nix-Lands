{
  config =
    {pkgs,inputs,...}:
    {
      # I don't use channels, and I don' care to setup nix-index
      programs.command-not-found.enable = false;
      # Less building text
      documentation = {
        enable = true;
        doc.enable = false;
        man.enable = true;
        nixos.enable = false;
        dev.enable = false;
      };
      # Nix options
      nix = {
        # Make builds run with low priority so my system stays responsive
        daemonCPUSchedPolicy = "idle";
        daemonIOSchedClass = "idle";
        # Better Error messages
        # package = pkgs.lixPackageSets.git.lix;
        package = pkgs.nixVersions.latest;
        # Optimize nix experience by removing cache and store garbage, on timer
        optimise.automatic = true;
        # disable channels completely
        channel.enable = false;
        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = [ "nixpkgs=flake:nixpkgs" ];
        settings = {
          # error on IFD, It errors on using modules like Stylix tho
          # right now it's true because I IFD a helium wrapper
          allow-import-from-derivation = false;
          # Optimize nix experience by removing cache and store garbage, per command
          # auto-optimise-store = true;
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          nix-path = [ "nixpkgs=flake:nixpkgs" ];
          flake-registry = ""; # optional, ensures flakes are truly self-contained
          # some options
          lint-short-path-literals = "warn";
          lint-url-literals = "warn";
        };
        # use token to not get limited by github api
        # thanks @dotKaktus for the !include, so it isn't an environmental variable
        # extraOptions = "!include ${config.sops.secrets."mystuff/github_token".path}";
      };
      # # secrets
      # sops.secrets."mystuff/github_token" = {
      #   neededForUsers = true;
      #   mode = "440";
      # };
      # nixpkgs options
      nixpkgs.config.allowUnfree = true;
    };
}
