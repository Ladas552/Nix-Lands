{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ... }:
    let
      # Use inputs from tack, instead of flake inputs
      inputs = (import ./.tack) { };
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
            {
              host,
              system ? "x86_64-linux",
              rocm ? false,
              cuda ? false,
              eval ? inputs.nixpkgs.lib.nixosSystem,
            }:
            mkSystem {
              specialArgs = { inherit inputs self; };
              paths = [ ./modules ];
              modules = [ ./options ];
              conditions = nosh.conditions.hasHost host;
              pkgs = import inputs.nixpkgs {
                inherit system;
                config = {
                  allowUnfree = true;
                  rocmSupport = rocm;
                  cudaSupport = cuda;
                };
              };
              inherit eval;
            };
        in
        {
          NixOSu = make {
            host = "pc";
            rocm = true;
          };
          NixPort = make {
            host = "laptop";
            rocm = true;
          };
          NixBox = make { host = "server"; };
          NixWool = make {
            host = "vps";
            system = "aarch64-linux";
          };
          NixwsL = make { host = "wsl"; };
          NixIso = make { host = "iso"; };
          NixTest = make { host = "testing"; };
          FinixOSu = make {
            host = "finix";
            eval = inputs.finix.lib.finixSystem;
          };
        };
      packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs self; });
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      templates = import ./templates;
    };
}
