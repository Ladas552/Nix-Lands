{ }:
{
  # one liners
  hotkey-overlay.skip-at-startup = true;
  xwayland-satellite.off = [ ];
  prefer-no-csd = true;
  screenshot-path = "~/Pictures/screenshots/Niri%Y-%m-%d %H-%M-%S.png";
  layout.default-column-display = "tabbed";
  gestures.hot-corners.off = [ ];
  # Autostart
  spawn-at-startup = [
    #   [
    #     "xfce4-power-manager"
    #     "--daemon"
    #   ]
    # [ "wpaperd" ]
    [
      "brightnessctl"
      "set"
      "37%"
    ]
    [
      "thunar"
      "-d"
    ]
  ];
  # theme
  cursor = {
    xcursor-theme = "default";
    xcursor-size = 24;
    hide-after-inactive-ms = 10000;
  };
  # Monitors
  output = [
    {
      _args = [ "eDP-1" ];
      scale = 1.5;
    }
    {
      _args = [ "HDMI-A-1" ];
      # scale = 2.0;
      scale = 1.0;
      mode = "1920x1080@60";
    }
  ];
  # Input Devices
  input = {
    workspace-auto-back-and-forth = true;
    keyboard = {
      xkb.layout = "canary,kz";
      xkb.options = "grp:caps_toggle";
    };
    mouse.accel-profile = "flat";
    touchpad = {
      tap = [ ];
      natural-scroll = [ ];
      middle-emulation = [ ];
      scroll-factor = 1.0;
    };
  };
  # Environmental Variables
  environment = {
    DISPLAY = ":0";
    TERMINAL = "kitty";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # make flameshot scale with 1.5 niri scale
    # QT_SCALE_FACTOR = "0.667";
  };
  # Looks & UI
  layout = {
    gaps = 8;
    center-focused-column = "never";
    default-column-width.proportion = 0.5;
    border.off = [ ];
    focus-ring = {
      width = 4;
      active-gradient._props = {
        from = "#7700AE";
        to = "#0060FF";
        angle = 45;
      };
    };
    tab-indicator = {
      hide-when-single-tab = true;
      place-within-column = true;
      position = "right";
      gaps-between-tabs = 10.0;
      width = 4.0;
      length._props.total-proportion = 0.1;
      corner-radius = 10.0;
      gap = -8.0;
      active-color = "#BA4B5D";
    };
    preset-column-widths._children = [
      # { proportion = 0.25; }
      { proportion = 0.5; }
      { proportion = 0.75; }
      { proportion = 1.0; }
    ];
  };
  # Window Rules
  window-rule = [
    # Shadows in floating mode
    {
      _children = [ { match._props.is-floating = true; } ];

      shadow.on = [ ];
    }
    {
      _children = [ { match._props.app-id = "mpv"; } ];
      shadow.off = [ ];
    }
    {
      _children = [
        { match._props.title = "Picture-in-Picture"; }
      ];
      default-column-width.fixed = 420;
      default-window-height.fixed = 236;
      default-floating-position._props = {
        x = 50;
        y = 50;
        relative-to = "bottom-right";
      };
      open-focused = false;
      open-floating = true;
    }
    # flameshot
    # thanks @saygo for window rule
    # {
    #   _children = [ { match._props.app-id = ''r#"flameshot"#''; } ];
    #   open-focused = true;
    #   open-floating = true;
    #   open-fullscreen = true;
    # }
    # Full screen/size apps
    {
      _children = [ { match._props.app-id = "steam_proton"; } ];
      default-column-width = { };
    }
    {
      _children = [
        { match._props.app-id = ".qemu-system-x86_64-wrapped"; }
        { match._props.app-id = "steam_app_0"; }
        { match._props.app-id = "darksoulsii.exe"; }
        { match._props.app-id = "steam-"; }
        { match._props.title = "DARK SOULS II"; }
        { match._props.app-id = "osu!"; }
        { match._props.title = "osu!"; }
      ];
      variable-refresh-rate = false;
      open-fullscreen = true;
      default-column-width.proportion = 1.0;
    }
    {
      _children = [
        { match._props.app-id = "firefox"; }
        { match._props.app-id = "thunderbird"; }
        { match._props.app-id = "vesktop"; }
        { match._props.app-id = "legcord"; }
      ];
      open-maximized-to-edges = true;
      default-column-width.proportion = 1.0;
    }
    # Screencast
    {
      _children = [
        { match._props.app-id._raw = ''r#"^org\.keepassxc\.KeePassXC$"#''; }
        { match._props.app-id._raw = ''r#"^org\.gnome\.World\.Secrets$"#''; }
      ];
      block-out-from = "screencast";
    }
    {
      _children = [
        { match._props.is-window-cast-target = true; }
      ];
      border = {
        on = [ ];
        active-color = "#BA4B5D";
        inactive-color = "#BA4B5D";
      };
    }
  ];
  switch-events = {
    lid-close.spawn = [
      "niri"
      "msg"
      "action"
      "power-off-monitors"
    ];
    lid-open.spawn = [
      "niri"
      "msg"
      "action"
      "power-on-monitors"
    ];
  };
  # Keybinds
  input.mod-key = "Super";
  binds = {
    # Apps
    "Super+T".spawn = "kitty";
    # "Super+E" .spawn ="emacs";
    "Super+M".spawn = [
      "neovide"
    ];
    "Super+N".spawn = [
      "kitty"
      "-e"
      "nvim"
      "-c"
      "Neorg journal today"
    ];
    "Super+E".spawn = [
      "kitty"
      "-e"
      "nvim"
      "-c"
      "Neorg workspace life"
    ];
    "Super+H".spawn = [
      "kitty"
      "-e"
      "rmpc"
    ];
    "Super+F".spawn = [
      "kitty"
      "-e"
      "btop"
    ];
    "Super+B".spawn = [
      "kitty"
      "-e"
      "qalc"
    ];
    # GUI apps
    "Super+K".spawn = "thunar";
    "Super+L".spawn = "firefox";
    "Shift+Super+L".spawn-sh = "helium &";
    # MPD
    "Shift+Alt+P" = {
      spawn = [
        "mpc"
        "toggle"
      ];
      _props.allow-when-locked = true;
    };
    "Shift+Alt+N" = {
      spawn = [
        "mpc"
        "next"
      ];
      _props.allow-when-locked = true;
    };
    "Shift+Alt+B" = {
      spawn = [
        "mpc"
        "prev"
      ];
      _props.allow-when-locked = true;
    };
    "Shift+Alt+K" = {
      spawn = [
        "mpc"
        "volume"
        "-5"
      ];
      _props.allow-when-locked = true;
    };
    "Shift+Alt+L" = {
      spawn = [
        "mpc"
        "volume"
        "+5"
      ];
      _props.allow-when-locked = true;
    };
    # "Shift+Alt+C".spawn = [
    #   "mpc"
    #   "clear"
    # ];
    "Shift+Alt+D".spawn = [ "musnow.sh" ];

    # Scripts
    "Super+D".spawn = [ "word-lookup.sh" ];
    #Example volume keys mappings for PipeWire & WirePlumber.
    #The allow-when-locked=true property makes them work even when the session is locked.
    "XF86AudioRaiseVolume" = {
      spawn = [
        "pamixer"
        "-i"
        "2"
        # "wpctl"
        # "set-volume"
        # "@DEFAULT_AUDIO_SINK@"
        # "0.02+"
      ];
      _props.allow-when-locked = true;
    };
    "XF86AudioLowerVolume" = {
      spawn = [
        "pamixer"
        "-d"
        "2"
        # "wpctl"
        # "set-volume"
        # "@DEFAULT_AUDIO_SINK@"
        # "0.02-"
      ];
      _props.allow-when-locked = true;
    };
    "XF86AudioMute" = {
      spawn = [
        "pamixer"
        "-t"
        # "wpctl"
        # "set-mute"
        # "@DEFAULT_AUDIO_SINK@"
        # "toggle"
      ];
      _props.allow-when-locked = true;
    };
    "XF86AudioMicMute" = {
      spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
      _props.allow-when-locked = true;
    };

    # Brightnes
    "XF86MonBrightnessUp" = {
      spawn = [
        "brightnessctl"
        "set"
        "10%+"
      ];
      _props.allow-when-locked = true;
    };
    "XF86MonBrightnessDown" = {
      spawn = [
        "brightnessctl"
        "set"
        "10%-"
      ];
      _props.allow-when-locked = true;
    };

    # shows a list of important hotkeys.
    "Super+Shift+K".show-hotkey-overlay = [ ];
    # Screenshots
    # was testing if it got better quility
    # "Print" .spawn =[
    #   "sh"
    #   "-c"
    #   "${lib.getExe pkgs.slurp} | ${lib.getExe pkgs.grim} -g -"
    # ];
    "Print".screenshot = [ ];
    # "Print" .spawn =[
    #   "flameshot"
    #   "gui"
    # ];
    # "Shift+Alt+Print" .spawn =[ "flameshot-ocr" ];
    "Shift+Print".screenshot-screen = [ ];
    "Alt+Print".screenshot-window = [ ];
    # Window Management
    "Super+W".close-window = [ ];
    # Floating Windows
    "Ctrl+Alt+R".toggle-window-floating = [ ];
    "Super+Tab".switch-focus-between-floating-and-tiling = [ ];
    # Tabbed layout
    "Ctrl+Alt+C".toggle-column-tabbed-display = [ ];

    "Super+Left".focus-column-left-or-last = [ ];
    "Super+Down".focus-window-down-or-top = [ ];
    "Super+Up".focus-window-up-or-bottom = [ ];
    "Super+Right".focus-column-right-or-first = [ ];
    "Super+C".focus-column-left-or-last = [ ];
    "Super+R".focus-column-right-or-first = [ ];

    "Super+Shift+Left".move-column-left = [ ];
    "Super+Shift+Down".move-window-down = [ ];
    "Super+Shift+Up".move-window-up = [ ];
    "Super+Shift+Right".move-column-right = [ ];
    "Super+Shift+C".move-column-left = [ ];
    "Super+Shift+R".move-column-right = [ ];

    "Super+Ctrl+Right".focus-monitor-right = [ ];
    "Super+Ctrl+Down".focus-monitor-down = [ ];
    "Super+Ctrl+Up".focus-monitor-up = [ ];
    "Super+Ctrl+Left".focus-monitor-left = [ ];

    "Super+Shift+Ctrl+Left".move-column-to-monitor-left = [ ];
    "Super+Shift+Ctrl+Down".move-column-to-monitor-down = [ ];
    "Super+Shift+Ctrl+Up".move-column-to-monitor-up = [ ];
    "Super+Shift+Ctrl+Right".move-column-to-monitor-right = [ ];
    "Super+Shift+F".move-column-to-monitor-left = [ ];
    "Super+Shift+N".move-column-to-monitor-down = [ ];
    "Super+Shift+E".move-column-to-monitor-up = [ ];
    "Super+Shift+I".move-column-to-monitor-right = [ ];

    "Super+Page_Up".focus-workspace-up = [ ];
    "Super+Page_Down".focus-workspace-down = [ ];

    "Super+Shift+Page_Up".move-column-to-workspace-up = [ ];
    "Super+Shift+Page_Down".move-column-to-workspace-down = [ ];
    # Mouse scroll
    "Super+WheelScrollDown" = {
      focus-workspace-down = [ ];
      _props.cooldown-ms = 150;
    };
    "Super+WheelScrollUp" = {
      focus-workspace-up = [ ];
      _props.cooldown-ms = 150;
    };
    "Super+Ctrl+WheelScrollDown" = {
      move-column-to-workspace-down = [ ];
      _props.cooldown-ms = 150;
    };
    "Super+Ctrl+WheelScrollUp" = {
      move-column-to-workspace-up = [ ];
      _props.cooldown-ms = 150;
    };

    "Super+WheelScrollRight".focus-column-right = [ ];
    "Super+WheelScrollLeft".focus-column-left = [ ];
    "Super+Ctrl+WheelScrollRight".move-column-right = [ ];
    "Super+Ctrl+WheelScrollLeft".move-column-left = [ ];

    "Super+Shift+WheelScrollDown".focus-column-right = [ ];
    "Super+Shift+WheelScrollUp".focus-column-left = [ ];
    "Super+Ctrl+Shift+WheelScrollDown".move-column-right = [ ];
    "Super+Ctrl+Shift+WheelScrollUp".move-column-left = [ ];

    # Touchpad gestures
    ## Workspaces
    "Super+Shift+TouchpadScrollUp".move-column-to-workspace-up = [ ];
    "Super+Shift+TouchpadScrollDown".move-column-to-workspace-down = [ ];
    "Super+TouchpadScrollUp".focus-workspace-up = [ ];
    "Super+TouchpadScrollDown".focus-workspace-down = [ ];
    ## Collumns
    "Super+TouchpadScrollRight".focus-column-right = [ ];
    "Super+TouchpadScrollLeft".focus-column-left = [ ];

    "Super+Shift+TouchpadScrollRight".move-column-right = [ ];
    "Super+Shift+TouchpadScrollLeft".move-column-left = [ ];
    # Workspaces
    "Super+1".focus-workspace = 1;
    "Super+2".focus-workspace = 2;
    "Super+3".focus-workspace = 3;
    "Super+Shift+1".move-column-to-workspace = 1;
    "Super+Shift+2".move-column-to-workspace = 2;
    "Super+Shift+3".move-column-to-workspace = 3;
    # Switches focus between the current and the previous workspace.

    # "Super+Tab" .focus-workspace-previous=[];

    "Super+Period".consume-window-into-column = [ ];
    "Super+Comma".expel-window-from-column = [ ];
    # There are also commands that consume or expel a single window to the side.
    "Super+BracketLeft".consume-or-expel-window-left = [ ];
    "Super+BracketRight".consume-or-expel-window-right = [ ];
    # Resize

    "Super+P".switch-preset-column-width = [ ];
    "Super+Shift+P".maximize-window-to-edges = [ ];
    "Super+Ctrl+T".maximize-column = [ ];
    "Super+Ctrl+D".center-column = [ ];
    "Super+Shift+T".fullscreen-window = [ ];
    "Super+Ctrl+Shift+T".toggle-windowed-fullscreen = [ ];

    "Alt+Ctrl+Left".set-column-width = "-10%";
    "Alt+Ctrl+Right".set-column-width = "+10%";

    "Alt+Ctrl+Up".set-window-height = "-10%";
    "Alt+Ctrl+Down".set-window-height = "+10%";

    "Super+Ctrl+Shift+W".quit = [ ];

    "Super+Shift+U".power-off-monitors = [ ];
    # Knob binds

    ## Brightness with a knob
    "Super+XF86AudioRaiseVolume" = {
      _props.allow-when-locked = true;
      spawn = [
        "brightnessctl"
        "set"
        "2%+"
      ];
    };
    "Super+XF86AudioLowerVolume" = {
      _props.allow-when-locked = true;
      spawn = [
        "brightnessctl"
        "set"
        "2%-"
      ];
    };

    ## Change mpd track with a knob
    "Shift+Alt+XF86AudioRaiseVolume" = {
      _props.allow-when-locked = true;
      spawn = [
        "mpc"
        "next"
      ];
    };
    "Shift+Alt+XF86AudioLowerVolume" = {
      _props.allow-when-locked = true;
      spawn = [
        "mpc"
        "prev"
      ];
    };
    "Shift+Alt+XF86AudioMute" = {
      _props.allow-when-locked = true;
      spawn = [
        "mpc"
        "shuffle"
      ];
    };

    ## Change collumn size with a knob
    "Alt+Ctrl+XF86AudioRaiseVolume".set-column-width = "+1%";
    "Alt+Ctrl+XF86AudioLowerVolume".set-column-width = "-1%";
    "Alt+Ctrl+XF86AudioMute".switch-preset-column-width = [ ];
  };
}
