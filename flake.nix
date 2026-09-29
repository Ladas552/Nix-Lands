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
            }
          )
        );
    in
    {
      nixosConfigurations =
        let
          make =
            x:
            mkSystem {
              specialArgs = { inherit inputs self; };
              paths = [ ./modules ];
              modules = [ ./options ];
              conditions = nosh.conditions.hasHost x;
            };
        in
        {
          NixOSu = make "pc";
          NixPort = make "laptop";
          NixBox = make "server";
          NixWool = make "vps";
          NixwsL = make "wsl";
          NixIso = make "iso";
          NixTest = make "testing";
        };
      packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs self; });
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      templates = ./templates;
    };
}
