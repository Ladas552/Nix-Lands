{
  enable = false;
  hosts = [ ];
  config = {
    # antivirus? Idk sounds cool. Don't need it on desktop tho
    services.clamav = {
      scanner = {
        enable = true;
        interval = "Sat *-*-* 04:00:00";
      };
      updater = {
        enable = true;
        frequency = 1;
        interval = "daily";
      };
      daemon.enable = true;
    };
  };
}
