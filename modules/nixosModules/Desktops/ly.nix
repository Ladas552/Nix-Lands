{
  hosts = [ "laptop" ];
  config = {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        battery_id = "BAT1";
        inactivity_cmd = "systemctl suspend";
        inactivity_delay = 300;
      };
    };
    security.pam.services.ly.fprintAuth = true;
  };
}
