{
  config =
    {
      pkgs,
      lib,
      inputs,
      ...
    }:
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
      nix =
        let
          flakes = lib.filterAttrs (_: input: lib.isType "flake" input) inputs;
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakes;
        in
        {
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
          registry = lib.mapAttrs (_: flake: { inherit flake; }) (
            removeAttrs inputs [
              "__functor"
              "adifox"
              "adios"
            ]
          );
          inherit nixPath;
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
            nix-path = nixPath;
            flake-registry = ""; # optional, ensures flakes are truly self-contained
            # some options
            lint-short-path-literals = "warn";
            lint-url-literals = "warn";
          };
        };
      # nixpkgs options
      nixpkgs.config.allowUnfree = true;
    };
}
