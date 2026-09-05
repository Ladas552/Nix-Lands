{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ... }@args:
    let
      # Use inputs from tack, instead of flake inputs
      inputs = (import ./.tack) {
        overrides = args.tackOverrides or { };
      };
      nosh = import ./lib { nixpkgs = inputs.nixpkgs; };
      mkSystem = nosh.mkSystem inputs.nixpkgs;

      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      # Provide simple per-system abstraction
      # giving you the system and
      # the package set for that system directly.
      eachSystem =
        f:
        inputs.nixpkgs.lib.genAttrs systems (
          system:
          f (
            import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.nvim.overlays.default
              ];
            }
          )
        );
    in
    {
      nixosConfigurations =
        let
          inherit (nosh.conditions) hasHost;
          specialArgs = { inherit inputs self; };
          paths = [ ./modules ];
          modules = [ ./options ];
        in
        {
          NixOSu = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "pc";
          };
          NixPort = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "laptop";
          };
          NixBox = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "server";
          };
          NixWool = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "vps";
          };
          NixwsL = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "wsl";
          };
          NixIso = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "iso";
          };
          NixTest = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "testing";
          };
        };
      packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs self; });
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      templates = ./templates;
    };
}
