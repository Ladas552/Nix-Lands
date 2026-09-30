# niri config for stationary machines, such as my pc
{
  NixOSu = {
    hj.niri.settings = {
      spawn-at-startup = [
        [ "vesktop" ]
        [ "firefox" ]
        [ "Telegram" ]
      ];
    };
  };
}
