{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config =
    {
      wrappers,
      meta,
      ...
    }:
    {
      environment.systemPackages = [
        # disable idle on host that don't need it
        (wrappers.noctalia {
          extraSettings =
            let
              toggle = if (meta.hostname == "NixOSu") then "false" else "true";
            in
            # toml
            fromTOML ''
              [idle]
              behavior_order = [ "screen-off", "lock-and-suspend", "lock" ]
              pre_action_fade_seconds = 4

              [idle.behavior.lock]
              action = "lock"
              enabled = false
              timeout = 600.0

              [idle.behavior.lock-and-suspend]
              action = "lock_and_suspend"
              enabled = ${toggle}
              timeout = 900.0

              [idle.behavior.screen-off]
              action = "screen_off"
              enabled = ${toggle}
              timeout = 300.0
            '';
        })
      ];

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".local/state/noctalia"
      ];
    };
}
