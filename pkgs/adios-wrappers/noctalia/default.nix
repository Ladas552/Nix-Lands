{ types, ... }@adios:
{
  options = {
    settings.mutators = [ "/noctalia" ];
    extraSettings = {
      mutators = [ "/noctalia" ];
      type = types.attrs;
      mergeFunc = adios.lib.merge.attrs.recursively;
    };
  };
  mutations."/noctalia".settings = _: fromTOML (builtins.readFile ./noctalia.toml);
  mutations."/noctalia".extraSettings = _: {
    idle.behavior = {
      lock.enabled = false;
      lock-and-suspend.enabled = false;
      screen-off.enabled = true;
    };
  };

  impl =
    { options, inputs }:
    let
      generator = inputs.nixpkgs.pkgs.formats.toml { };
    in
    assert !(options ? settings && options ? configFile);
    inputs.mkWrapper {
      inherit (options) package;
      symlinks = {
        "$out/noctalia/noctalia.toml" =
          if options ? extraSettings && options ? settings then
            generator.generate "noctalia.toml" (options.settings // options.extraSettings)
          else if options ? settings then
            generator.generate "noctalia.toml" options.settings
          else
            null;
      };
      environment = {
        NOCTALIA_CONFIG_HOME = "$out";
      };
    };
}
