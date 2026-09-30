{
  # entry point for flake commands for backwards compatibility
  # points to ./default.nix
  # instead of evaluating the flake.nix, evaluate default.nix directly
  outputs = _: (import ./.) { };
}
