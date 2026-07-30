# The implementation stolen from @viperML, just without the wrapping library
# https://github.com/viperML/dotfiles/blob/master/modules/wrapper-manager/fish/default.nix
{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs)
    fish
    writeTextDir
    zoxide
    direnv
    nix-direnv
    ;
  inherit (lib) getExe;

  vendorConf = "share/fish/vendor_conf.d";

  loadPlugin =
    writeTextDir "${vendorConf}/load.fish"
      # fish
      ''
        function load_plugin
          if test (count $argv) -lt 1
            echo Failed to load plugin, incorrect number of arguments
            return 1
          end
          set -l __plugin_dir $argv[1]/share/fish
          if test -d $__plugin_dir/vendor_functions.d
            set -p fish_function_path $__plugin_dir/vendor_functions.d
          end
          if test -d $__plugin_dir/vendor_completions.d
            set -p fish_complete_path $__plugin_dir/vendor_completions.d
          end
          if test -d $__plugin_dir/vendor_conf.d
            for f in $__plugin_dir/vendor_conf.d/*.fish
              source $f
            end
          end
        end
      '';

  config =
    writeTextDir "${vendorConf}/config.fish"
      # fish
      ''
        # Only source once
        # set -q __fish_config_sourced; and exit
        # set -gx __fish_config_sourced 1
        set fish_greeting

        ${lib.pipe
          (with pkgs.fishPlugins; [
            autopair
            pure
            puffer
            sponge
            foreign-env
            fzf-fish
          ])
          [
            (map (elem: "load_plugin ${elem}"))
            (lib.concatStringsSep "\n")
          ]
        }

        # NixOS's /etc/profile already exits early with __ETC_PROFILE_SOURCED
        # For some reason, status is-login doesn't work consistently
        fenv source /etc/profile

        # nix-direnv integration
        set -gx direnv_config_dir ${nix-direnv}/share/nix-direnv/direnvrc
        ${getExe direnv} hook fish | source

        # zoxide integration
        ${getExe zoxide} init fish | source
        # Abbrs
        abbr --set-cursor --command nix rn run nixpkgs#%
        abbr --set-cursor --command nix bn build nixpkgs#%
        abbr --set-cursor --command nix sn shell nixpkgs#%
        abbr --set-cursor --command nix rg run github:%
        abbr --set-cursor --command nix bg build github:%
        abbr --set-cursor --command nix sg shell github:%
        abbr --set-cursor --command nix nr run nixpkgs#%
        abbr --set-cursor --command nix nb build nixpkgs#%
        abbr --set-cursor --command nix ns shell nixpkgs#%
        abbr --set-cursor --command nix gr run github:%
        abbr --set-cursor --command nix gb build github:%
        abbr --set-cursor --command nix gs shell github:%

      '';
in
pkgs.symlinkJoin {
  name = "fish";
  meta.mainProgram = "fish";
  paths = [
    # bin
    fish
    # functinos
    loadPlugin
    config
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/fish \
    --prefix XDG_DATA_DIRS : ${
      lib.makeSearchPathOutput "out" "share" [
        loadPlugin
        config
      ]
    }
  '';
}
