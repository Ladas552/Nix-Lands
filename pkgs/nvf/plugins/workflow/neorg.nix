{
  lib,
  pkgs,
  myself,
  ...
}:
let
  # nvfetcher pins
  sources = pkgs.callPackage "${myself}/_sources/generated.nix" { };
  # Neorg Plugins
  lib-neorg_query = pkgs.rustPlatform.buildRustPackage {
    src = sources.neorg-query.src;
    name = "neorg_query";
    # change this to cargoLock somehow
    cargoHash = "sha256-Kj4KOGdgLh8HYDUqg17AvRKLAcEKI71ASF/jPj95l0w=";
    nativeBuildInputs = [ pkgs.gitMinimal ];
    doCheck = false;
  };
  neorg-query = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-query";
    src = sources.neorg-query.src;
    preInstall =
      let
        ext = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
      in
      ''
        mkdir -p $out/lua/neorg_query
        ln -s ${lib-neorg_query}/lib/libneorg_query${ext} $out/lua/
      '';
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.query.module"
      "neorg_query.formatter"
      "neorg_query.api"
    ];
  };
  neorg-interim-ls = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-interim-ls";
    src = sources.neorg-interim-ls.src;
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.lsp-completion.module"
      "neorg.modules.external.interim-ls.module"
      "neorg.modules.external.refactor.module"
    ];
  };
  neorg-conceal-wrap = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-conceal-wrap";
    src = sources.neorg-conceal-wrap.src;
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.conceal-wrap.module"
    ];
  };
  neorg = pkgs.vimUtils.buildVimPlugin {
    name = "neorg";
    src = sources.neorg.src;
  };
in
{
  vim = {
    lazy.plugins.vimplugin-neorg = {
      package = lib.mkForce (neorg.overrideAttrs { doCheck = false; });
    };
    extraPlugins = {
      "neorg-interim-ls".package = neorg-interim-ls;
      "neorg-conceal-wrap".package = neorg-conceal-wrap;
      "neorg_query".package = neorg-query;
    };
    notes.neorg = {
      enable = true;
      treesitter.enable = true;
      setupOpts.load = {
        # Extra modules
        "external.query" = {
          config = {
            index_on_launch = true;
            update_on_change = true;
          };
        };
        "external.interim-ls".config.completion_provider.categories = true;
        # Core
        "core.defaults".enable = true;
        "core.concealer".config.icon_preset = "diamond";
        "core.esupports.metagen" = {
          config = {
            timezone = "implicit-local";
            type = "empty";
            undojoin_updates = false;
          };
        };
        "core.tangle".config = {
          report_on_empty = true;
          tangle_on_write = false;
        };
        "core.completion".config.engine.module_name = "external.lsp-completion";
        "core.keybinds" = {
          config = {
            default_keybinds = true;
            neorg_leader = "<Leader><Leader>";
          };
        };
        "core.journal" = {
          config = {
            workspace = "journal";
            journal_folder = "./";
            journals =
              lib.generators.mkLuaInline # lua
                ''
                  {canary = {
                     start_date = os.time({ year = 2026, month = 04, day = 6 }), -- a Monday
                     period = { day = 1 },
                     path_format_strategy = "%Y/%m/%d-canary.norg",
                     parse_journal_path = nil,
                   }}
                '';
            holidays = lib.generators.mkLuaInline ''
              {
              os.time({ month = 1, day = 1, year = 2026 }),
              }
            '';
          };
        };
        "core.dirman" = {
          config = {
            workspaces =
              let
                doc = "~/Documents/Norg";
              in
              {
                general = "${doc}";
                life = "${doc}/Life";
                work = "${doc}/Study";
                journal = "${doc}/Journal";
                archive = "${doc}/Archive";
              };
            default_workspace = "general";
          };
        };
        "core.summary" = { };
      };
    };
    globals.maploalleader = "  ";
    options = {
      foldlevel = 99;
      conceallevel = 2;
    };
    keymaps = [
      #Neorg Journal
      {
        action = "<cmd>Neorg journal today<CR>";
        key = "<leader>j";
        mode = "n";
        desc = "Journal today";
      }
    ];
  };
}
