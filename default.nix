# My config's entry, like outputs of flake.nix but available as attribute sets to non flake commands. Can also be read via the flake commands
# To eval nixos configuration use this nh command
# nh os switch -t -f . nixosConfigurations.HOST
let
  # Use inputs from tack, with flake like structure
  inputs = (import ./.tack) { };
  # Read system impurely from `builtins.currentSystem`
  pkgs = import inputs.nixpkgs { config.allowUnfree = true; };
  # get additional inputs from nvfetcher
  sources = pkgs.callPackage ./_sources/generated.nix { };

  # custom packages for hosts
  wrappers = import ./pkgs { inherit inputs pkgs sources; };

  # lib to create nixosConfigurations
  nosh = import ./lib { nixpkgs = inputs.nixpkgs; };
  mkSystem = nosh.mkSystem inputs.nixpkgs;

  # Provide simple per-system abstraction
  # giving you the system and
  # the package set for that system directly.
  systems = inputs.nixpkgs.lib.systems.flakeExposed;

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
  outputs = { }: {
    nixosConfigurations =
      let
        make =
          x:
          mkSystem {
            specialArgs = { inherit inputs sources wrappers; };
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
    packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs sources; });
    formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
  };
in
outputs
