{ types, promise, ... }:
{
  options = {
    settings.default = fromTOML (builtins.readFile ./noctalia.toml);
    extraSettings = {
      type = types.attrs;
      default = { };
    };
  };

  inputs.mkWrapper.options = promise (
    { options, inputs }:
    let
      generator = inputs.nixpkgs.pkgs.formats.toml { };
    in
    {
      inherit (options) package;
      symlinks = {
        "$out/noctalia/noctalia.toml" =
          if options ? settings then
            generator.generate "noctalia.toml" (options.settings // options.extraSettings)
          else
            null;
      };
      environment = {
        NOCTALIA_CONFIG_HOME = "$out";
      };
    }
  );
}
