{
  # Changes niri focus ring colors based off neovim mode
  # Idea stolen from https://www.reddit.com/r/niri/comments/1rjrd26/border_color_depending_on_the_current_neovim_mode/
  # and yeah, the code is bad. And don't open more than one neovim window at a time
  flake.modules = {
    nvf.niri-nvim-colors =
      { lib, ... }:
      {
        vim = {
          augroups = [
            {
              name = "NiriModeColor";
              clear = true;
            }
          ];
          autocmds = [
            {
              event = [
                "ModeChanged"
                "FocusGained"
              ];
              pattern = [ "*" ];
              group = "NiriModeColor";
              desc = "change the niri focus-ring color depending on the mode";
              callback =
                lib.generators.mkLuaInline # lua
                  ''
                    function()
                        local f = io.open(vim.fn.expand("~/.config/niri/niri-nvim-colors.kdl"), "w")
                        if not f then return end
                        f:write(({
                          i  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#a6da95"\n\t}\n}\n',
                          v  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#c6a0f7"\n\t}\n}\n',
                          V  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#c6a0f7"\n\t}\n}\n',
                          ["\22"]  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#c6a0f7"\n\t}\n}\n',
                          R  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#ed8797"\n\t}\n}\n',
                           c  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#f5a980"\n\t}\n}\n',
                          n  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#8aadf5"\n\t}\n}\n',
                          t  = 'layout {\n\tfocus-ring {\n\t\tactive-color "#a6da95"\n\t}\n}\n',
                        })[vim.fn.mode()] or 'layout {\n\tfocus-ring {\n\t\tactive-gradient angle=45 from="#7700AE" to="#0060FF"\n\t}\n}\n')
                        f:close()
                        vim.fn.jobstart({ "niri", "msg", "action", "reload-config" }, { detach = true })
                      end
                  '';
            }
            {
              event = [
                "VimLeave"
                "FocusLost"
              ];
              group = "NiriModeColor";
              desc = "return niri focud-ring to default color";
              callback =
                lib.generators.mkLuaInline # lua
                  ''
                    function()
                      local f = io.open(vim.fn.expand("~/.config/niri/niri-nvim-colors.kdl"), "w")
                      if not f then return end
                      f:write('layout {\n\tfocus-ring {\n\t\tactive-gradient angle=45 from="#7700AE" to="#0060FF"\n\t}\n}\n')
                      f:close()
                      vim.fn.jobstart({ "niri", "msg", "action", "reload-config" }, { detach = true })
                    end
                  '';
            }
          ];
        };
      };
    hjem.niri-nvim-colors = {
      niri.extraConfig = # kdl
        ''
          include optional=true "niri-nvim-colors.kdl"
        '';

      xdg.config.files."niri/niri-nvim-colors.kdl" = {
        type = "copy";
        permissions = "666";
        text = # kdl
          ''
            layout {
            	focus-ring {
            		active-gradient angle=45 from="#7700AE" to="#0060FF"
            	}
            }
          '';
      };
    };
  };
}
