{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ... }@args:
    let
      # Use inputs from tack, instead of flake inputs
      inputs = (import ./.tack) {
        overrides = args.tackOverrides or { };
      };
      mkSystem = inputs.nosh.lib.mkSystem inputs.nixpkgs;

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
            }
          )
        );
    in
    {
      nixosConfigurations =
        let
          inherit (inputs.nosh.lib.conditions) hasHost;
          specialArgs = { inherit inputs self; };
          paths = [ ./modules ];
          modules = [ ./options ];
        in
        {
          NixPort = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "laptop";
            system = "x86_64-linux";
          };
          NixToks = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "server";
            system = "x86_64-linux";
          };
          NixWool = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "vps";
            system = "aarch64-linux";
          };
          NixwsL = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "wsl";
            system = "x86_64-linux";
          };
          NixIso = mkSystem {
            inherit paths modules specialArgs;
            conditions = hasHost "iso";
            system = "x86_64-linux";
          };
        };
      packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs self; });
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      templates = ./templates;
    };
}
