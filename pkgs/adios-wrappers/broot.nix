{ types, ... }:
{
  inputs = {
    mkWrapper.from = { parent }: parent.mkWrapper;
    nixpkgs.from = { parent }: parent.nixpkgs;
  };

  options = {
    settings = {
      type = types.attrs;
      default = {
        default_flags = "-gh";
        verbs = [
          {
            invocation = "create {name}";
            execution = "bonk {name}";
            key = "F1";
            leave_broot = false;
            auto_exec = false;
          }
          {
            invocation = "shell";
            execution = "$SHELL";
            key = "ctrl-s";
            set_working_dir = true;
            leave_broot = false;
          }
          {
            invocation = "edit";
            shortcut = "e";
            external = "$EDITOR {file:space-separated}";
            key = "Right";
            leave_broot = false;
          }
          {
            invocation = "rip";
            external = "ripdrag -a -x -b {file:space-separated}";
            key = "ctrl-u";
            leave_broot = false;
          }
        ];
      };
      description = "";
    };
    configFiles = {
      type = types.listOf types.pathLike;
      description = "";
    };

    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.broot;
      description = "The Broot package to be wrapped.";
    };
  };

  mutations."/fish".interactiveShellInit =
    { options }:
    # fish
    ''
      source "${options.package}/share/fish/vendor_conf.d/vendor_functions.d/br.fish"
      set --prepend fish_complete_path "${options.package}/share/fish/vendor_completions.d"
    '';

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) formats;
      inherit (builtins) listToAttrs;
      generator = formats.toml { };
    in
    assert !(options ? settings && options ? configFile);
    inputs.mkWrapper {
      inherit (options) package;
      symlinks = {
        "$out/broot/conf.toml" =
          if options ? settings then generator.generate "conf.toml" options.settings else null;
      }
      // (
        if options ? configFiles then
          listToAttrs (
            map (path: {
              name = "$out/broot/${baseNameOf path}";
              value = path;
            }) options.configFiles
          )
        else
          { }
      );
      environment = {
        BROOT_CONFIG_DIR = "$out/broot";
      };
    };

}
