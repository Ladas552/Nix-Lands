{
  enable = false;
  hosts = [ "laptop" ];
  config = {
    hj.rum.programs.zed = {
      enable = true;
      settings = {
        auto_install_extensions = {
          nix = true;
          toml = true;
          catppuccin = true;
          catppuccin-icons = true;
          elixir = true;
          elixir-snippets = true;
          typst = true;
          fish = true;
          python-snippets = true;
          emmylua = true;
        };
        git_panel.tree_view = true;
        window_decorations = "server";
        terminal = {
          toolbar.breadcrumbs = false;
          shell.program = "fish";
        };
        search = {
          regex = true;
          include_ignored = true;
        };
        use_smartcase_search = true;
        diagnostics.inline.enabled = true;
        semantic_tokens = "combined";
        auto_update = false;
        indent_guides.enabled = false;
        show_wrap_guides = false;
        soft_wrap = "editor_width";
        tab_size = 2;
        toolbar.agent_review = false;
        scrollbar = {
          axes = {
            vertical = false;
            horizontal = false;
          };
          show = "never";
        };
        relative_line_numbers = "wrapped";
        autoscroll_on_clicks = true;
        vertical_scroll_margin = 3.0;
        scroll_beyond_last_line = "off";
        which_key = {
          delay_ms = 3000;
          enabled = true;
        };
        helix_mode = true;
        agent = {
          favorite_models = [ ];
          model_parameters = [ ];
          tool_permissions = {
            default = "deny";
            tools = { };
          };
        };
        disable_ai = true;
        rounded_selection = false;
        hide_mouse = "never";
        ui_font_family = "JetBrainsMono Nerd Font Mono";
        buffer_font_family = "JetBrainsMono Nerd Font Mono";
        session.trust_all_worktrees = true;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        icon_theme = "Catppuccin Macchiato";
        ui_font_size = 15;
        buffer_font_size = 15;
        theme = "Catppuccin Macchiato - No Italics";
      };
      keymap = [
        {
          bindings.escape = "vim::HelixCollapseSelection";
          context = "vim_mode == helix_select";
        }
        {
          bindings.escape = "vim::HelixCollapseSelection";
          context = "((vim_mode == helix_normal || vim_mode == helix_select) && !menu)";
        }
      ];
    };
    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".local/share/zed" ];
  };
}
