{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.umbriel.nixosModules.default
      ];
      programs.umbriel.enable = true;
      environment.systemPackages = with pkgs; [
        brightnessctl
        wl-clipboard
        xwayland
      ];
      environment.variables = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
      };
      hjem.extraModules = [ inputs.umbriel.hjemModules.default ];
      # set options for umbriel
      hj.programs.umbriel = {
        enable = true;
        package = null;
        settings = {
          environment = {
            NIXOS_OZONE_WL = "1";
            ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
          };
          general = {
            autostart = [
              "noctalia"
              "brightnessctl set 37%"
              "thunar -d"
              "kitty --start-as=hidden --single-instance"
            ];
            xwayland = true;
            show_cheatsheet = false;
            focus_on_activate = true;
            honor_restored_maximize = true;
          };
          output = {
            eDP-1 = {
              scale = 1.5;
              workspaces = 5;
            };
            HDMI-A-1 = {
              mode = "1920x1080@60";
              workspaces = 5;
            };
            DP-1 = {
              mode = "1920x1080@239.998";
              vrr = "disabled";
              tearing = true;
              workspaces = 5;
            };
          };
          input = {
            middle_click_paste = true;
            client_window_drag = false;
            window_drag_toggle = "floating";
            tablet.enabled = false;
            touch.enabled = false;
            cursor.hide_timeout_ms = 10000;
            focus.follows_mouse = false;
          };
          # Looks
          appearance = {
            prefer_no_csd = true;
            border_width = 4;
            corner_radius = 0;
            shadow.enabled = false;
          };
          colors.border = {
            focused = "#0060FF";
            unfocused = "#00000000";
          };
          animation.border.enabled = false;
          layout = {
            gap = 2;
            scrolling.default_extent_fraction = 0.5;
            extent_presets = [
              0.5
              0.75
              1.0
            ];
          };
          workspaces.back_and_forth = true;
          window_rule = [
            {
              match = {
                app_id = [
                  ".qemu-system-x86_64-wrapped"
                  "steam_app_0"
                  "darksoulsii.exe"
                  "osu!"
                  "steam-"
                  "steam_proton"
                ];
                title = [
                  "DARK SOULS II"
                  "osu!"
                ];
              };
              default_fullscreen = true;
              default_scrolling_extent = 1.0;
            }
            {
              match.is_floating = true;
              shadow = true;
            }
            {
              match.app_id = "mpv";
              shadow = false;
            }
            {
              match.is_cast_target = true;
              border_color_focused = "#BA4B5D";
              border_color_unfocused = "#BA4B5D";
            }
            {
              match.app_id = [
                ''r#"^org\.keepassxc\.KeePassXC$"#''
                ''r#"^org\.gnome\.World\.Secrets$"#''
              ];
              block_capture = true;
            }
            {
              match.app_id = [
                "helium"
                "firefox"
                "thunderbird"
                "element-desktop"
                "vesktop"
              ];
              default_scrolling_extent = 1.0;
              default_maximize_to_edges = true;
            }
          ];
          workspace = [
            {
              index = 3;
              layout.mode = "master";
            }
            {
              index = 4;
              layout.mode = "stacking";
            }
          ];

          keybinds = {
            # noctalia
            "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
            "Mod+V" = "spawn noctalia msg panel-toggle session";
            "Mod+D" = "spawn noctalia msg bar-toggle";
            "Mod+W".action = "window-close";
            "Mod+Ctrl+Shift+W" = "session-quit";

            # Kitty apps
            "Mod+T".action = "spawn kitty --single-instance";
            "Mod+J" = "spawn kitty --single-instance -e nvim -c 'Neorg journal today'";
            "Mod+E" = "spawn kitty --single-instance -e nvim -c 'Neorg workspace life'";
            "Mod+M" = "spawn kitty --single-instance -e rmpc";
            "Mod+H" = "spawn kitty --single-instance -e btop";
            "Mod+G" = "spawn kitty --single-instance -e qalc";

            # GUI apps
            "Mod+F" = "spawn thunar";
            "Mod+L" = "spawn helium";

            # MPD
            "Shift+Alt+P" = {
              action = "spawn mpc toggle";
              allow_when_locked = true;
            };
            "Shift+Alt+N" = {
              action = "spawn mpc next";
              allow_when_locked = true;
            };
            "Shift+Alt+B" = {
              action = "spawn mpc prev";
              allow_when_locked = true;
            };
            "Shift+Alt+W" = {
              action = "spawn mpc volume -5";
              allow_when_locked = true;
            };
            "Shift+Alt+L" = {
              action = "spawn mpc volume +5";
              allow_when_locked = true;
            };
            # "Shift+Alt+C" = "spawn mpc clear";
            "Shift+Alt+D" = "spawn musnow.sh";

            # Media, volume and brightness keys from any input device, routed through the
            # Noctalia shell so its OSDs show. Safe while the session is locked.
            # https://docs.noctalia.dev/noctalia/compositor-settings/umbriel
            "XF86AudioRaiseVolume" = {
              action = "spawn noctalia msg volume-up";
              allow_when_locked = true;
            };
            "XF86AudioLowerVolume" = {
              action = "spawn noctalia msg volume-down";
              allow_when_locked = true;
            };
            "XF86AudioMute" = {
              action = "spawn noctalia msg volume-mute";
              allow_when_locked = true;
              repeat = false;
            };
            # Previous pamixer / wpctl volume bindings (replaced by the Noctalia ones above):
            "XF86AudioMicMute" = {
              action = "spawn wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
              allow_when_locked = true;
            };
            "XF86AudioPlay" = {
              action = "spawn noctalia msg media toggle";
              allow_when_locked = true;
              repeat = false;
            };
            "XF86AudioNext" = {
              action = "spawn noctalia msg media next";
              allow_when_locked = true;
            };
            "XF86AudioPrev" = {
              action = "spawn noctalia msg media previous";
              allow_when_locked = true;
            };

            # Brightness
            "XF86MonBrightnessUp" = {
              action = "spawn brightnessctl set 10%+";
              allow_when_locked = true;
            };
            "XF86MonBrightnessDown" = {
              action = "spawn brightnessctl set 10%-";
              allow_when_locked = true;
            };

            # Knob binds

            ## Brightness with a knob
            "Mod+XF86AudioRaiseVolume" = {
              action = "spawn brightnessctl set 2%+";
              allow_when_locked = true;
            };
            "Mod+XF86AudioLowerVolume" = {
              action = "spawn brightnessctl set 2%-";
              allow_when_locked = true;
            };

            ## Change mpd track with a knob
            "Shift+Alt+XF86AudioRaiseVolume" = {
              action = "spawn mpc next";
              allow_when_locked = true;
            };
            "Shift+Alt+XF86AudioLowerVolume" = {
              action = "spawn mpc prev";
              allow_when_locked = true;
            };
            "Shift+Alt+XF86AudioMute" = {
              action = "spawn mpc shuffle";
              allow_when_locked = true;
            };

            # Focus and movement
            "Mod+Left" = "window-focus-left";
            "Mod+Down" = "window-focus-down";
            "Mod+Up" = "window-focus-up";
            "Mod+Right" = "window-focus-right";
            "Mod+R" = "window-focus-right";
            "Mod+C" = "window-focus-left";
            "Mod+Shift+Left" = "column-move-left";
            "Mod+Shift+Down" = "window-move-down";
            "Mod+Shift+Up" = "window-move-up";
            "Mod+Shift+Right" = "column-move-right";
            "Mod+Shift+R" = "column-move-right";
            "Mod+Shift+C" = "column-move-left";
            # Resize
            "Ctrl+Alt+Right" = "window-modify-primary-extent 0.05";
            "Ctrl+Alt+Left" = "window-modify-primary-extent -0.05";
            "Ctrl+Alt+Up" = "window-modify-secondary-extent -0.05";
            "Ctrl+Alt+Down" = "window-modify-secondary-extent 0.05";

            # Window state and layout
            "Mod+Shift+F".action = "window-toggle-floating";
            "Mod+Tab".action = "window-focus-switch-floating";
            "Mod+Shift+X".action = "window-toggle-pinned";
            "Mod+Shift+P".action = "window-toggle-maximize-to-edges";
            "Mod+Shift+T".action = "window-toggle-fullscreen";
            "Mod+P" = "window-cycle-primary-extent";
            "Mod+Comma" = "window-consume-left";
            "Mod+Period" = "window-consume-right";
            "Ctrl+Alt+C".action = "column-toggle-tabbed";
            "Mod+Alt+Right" = "column-focus-tab-next";
            "Mod+Alt+Left" = "column-focus-tab-previous";
            "Mod+WheelUp" = "window-focus-left";
            "Mod+WheelDown" = "window-focus-right";

            # Workspaces
            # Move the whole workspace, retaining its name, layout, and windows.
            "Mod+Ctrl+Page_Down" = "workspace-move-to-output-next";
            "Mod+Ctrl+Page_Up" = "workspace-move-to-output-previous";
            "Mod+Ctrl+W" = "workspace-move-to-output current WEB --output DP-1";
            "Mod+1" = "workspace-switch 1";
            "Mod+2" = "workspace-switch 2";
            "Mod+3" = "workspace-switch 3";
            "Mod+4" = "workspace-switch 4";
            "Mod+Shift+1" = "window-move-to-workspace 1";
            "Mod+Shift+2" = "window-move-to-workspace 2";
            "Mod+Shift+3" = "window-move-to-workspace 3";
            "Mod+Shift+4" = "window-move-to-workspace 4";
          };
        };
      };
    };
}
