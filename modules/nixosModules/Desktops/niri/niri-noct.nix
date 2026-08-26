{
  hosts = [ "laptop" "iso"];
  config = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.gpu-screen-recorder
    ];
    hj.niri.settings = {
      # autostart noctalia-shell
      spawn-at-startup = [
        [ "noctalia" ]
      ];
      # overview wallpaper
      layer-rule = [
        {
          # Noctalia wallpaper in overview
          _children = [ { match._props.namespace = "^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
      ];
      # noctalia tools
      binds = {
        # Noctalia
        "Super+Space".spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "launcher"
        ];
        "Super+V".spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "session"
        ];
        "Super+D".spawn = [
          "noctalia"
          "msg"
          "bar-toggle"
        ];
      };
    };
  };
}
