_: {
  options = {
    interactiveShellInit.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs.lib) pipe getExe concatStringsSep;
        inherit (inputs.nixpkgs.pkgs) fishPlugins direnv zoxide nix-direnv;
      in
      # fish
      ''
          # config
        set fish_greeting

          # plugins
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

        ${pipe
          (with fishPlugins; [
            autopair
            pure
            puffer
            sponge
            foreign-env
            fzf-fish
          ])
          [
            (map (elem: "load_plugin ${elem}"))
            (concatStringsSep "\n")
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
      '';
abbreviations.default = let 
  c = expansion: {
    setCursor = true;
    inherit expansion;
  };
    in{
      nix = {
          "bg" = c "build github:%";
          "bn" = c "build nixpkgs#%";
          "gb" = c "build github:%";
          "gr" = c "run github:%";
          "gs" = c "shell github:%";
          "nb" = c "build nixpkgs#%";
          "nr" = c "run nixpkgs#%";
          "ns" = c "shell nixpkgs#%";
          "rg" = c "run github:%";
          "rn" = c "run nixpkgs#%";
          "sg" = c "shell github:%";
          "sn" = c "shell nixpkgs#%";
      };
    };
  };
}
