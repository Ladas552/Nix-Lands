# niri config for stationary machines, such as my pc
{
  hosts = [
    "pc"
  ];
  config = {
    hj.niri.settings = {
      spawn-at-startup = [
        [ "vesktop" ]
        [ "firefox" ]
        [ "Telegram" ]
      ];
    };
  };
}
