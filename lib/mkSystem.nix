# forked from https://codeberg.org/poacher/nosh
# it's a small script to make hosts out of modulus
nixpkgs: pkgs:
let
  inherit (pkgs.lib) concatMap hasSuffix filesystem;
  inherit (builtins) isPath filter readFileType;
  expandIfFolder =
    elem:
    if !isPath elem || readFileType elem != "directory" then
      [ elem ]
    else
      filesystem.listFilesRecursive elem;
in
{
  conditions ? _: true,
  paths ? [ ],
  modules ? [ ],
  nixosSystem ? import "${nixpkgs}/nixos/lib/eval-config.nix",
  specialArgs ? { },
  system ? null,
}:
nixosSystem {
  inherit system specialArgs;
  modules =
    modules
    ++
      map
        (
          path:
          let
            module = import path;
          in
          if (module.enable or true) && module ? config && conditions module then module.config else { }
        )
        (
          filter
            # Filter out any path that doesn't look like `*.nix`. Don't forget to use
            # toString to prevent copying paths to the store unnecessarily
            (
              path:
              let
                pathString = toString path;
              in
              !isPath path || hasSuffix ".nix" pathString
            )
            # Expand any folder to all the files within it.
            (concatMap expandIfFolder paths)
        );
}
