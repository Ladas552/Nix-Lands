{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ... }:
    let
      # Use inputs from tack, instead of flake inputs
      inputs = (import ./.tack) {
      };

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
      nixosConfigurations = inputs.prism.lib.mkSystems {
        specialArgs = { inherit inputs self; };
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        mkSystem = inputs.nixpkgs.lib.nixosSystem;
        modules = inputs.prism.lib.recursivelyImport [ ./modules ];
        extraModules = [ ./options ];
        tags =
          self: with self; {
            inherit (inputs.prism.lib.presets) all these;
            # pc
            NixOSu.parents = [
              all
              games
              noctalia
              workstation
              virtualisation
              llm
            ];
            # laptop
            NixPort.parents = [
              all
              noctalia
              workstation
              powermanagment
              pocket
            ];
            # server
            NixBox.parents = [
              all
              edit
              linux
              private
              powermanagment
            ];
            # vps
            NixWool.parents = [
              all
              arm
              public
            ];
            # wsl
            NixwsL.parents = [
              all
              edit
              linux
              vm
            ];
            # iso
            NixIso.parents = [
              all
              noctalia
              gui
              linux
              pocket
              powermanagment
            ];
            # testing
            NixTest.parents = [
              all
              linux
              vm
            ];

            # tags for system architecture
            linux-rocm.pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config = {
                allowUnfree = true;
                rocmSupport = true;
              };
            };
            linux.pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            arm.pkgs = import inputs.nixpkgs {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
            # general tags
            edit = { };
            games = { };
            gui = { };
            hardware = { };
            llm = { };
            local = { };
            pocket = { };
            powermanagment = { };
            virtualisation = { };
            vm = { };
            # desktop environments
            budgie = { };
            cage = { };
            cagebreak = { };
            cosmic = { };
            gnome = { };
            niri = { };
            xfce = { };
            # specific tags
            noctalia.parents = [
              niri
              gui
            ];
            private.parents = [
              selfhost
              local
            ];
            public.parents = [ selfhost ];
            selfhost.parents = [ hardware ];
            workstation.parents = [
              hardware
              linux-rocm
              local
              edit
            ];
          };
      };
      packages = eachSystem (pkgs: import ./pkgs { inherit inputs pkgs self; });
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      templates = ./templates;
    };
}
