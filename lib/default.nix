{ nixpkgs }:
{
  mkSystem = import ./mkSystem.nix nixpkgs;
  conditions = import ./conditions.nix;
}
