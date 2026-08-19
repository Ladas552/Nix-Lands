# forked from https://codeberg.org/poacher/nosh
# it's a small script to make hosts out of modulus
nixpkgs: pkgs:
let
  inherit (pkgs.lib) concatMap hasSuffix hasPrefix;
  inherit (builtins) attrNames readDir;
  listNixFilesRecursive =
    folder:
    let
      contents = readDir folder;
    in
    concatMap (
      filename:
      let
        type = contents.${filename};
      in
      if type == "regular" && hasSuffix ".nix" filename && !hasPrefix "_" filename then
        [ (folder + "/${filename}") ]
      else if type == "directory" then
        listNixFilesRecursive (folder + "/${filename}")
      else
        [ ]
    ) (attrNames contents);
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
          # Expand any folder to all the files within it.
          concatMap listNixFilesRecursive paths
        );
}
