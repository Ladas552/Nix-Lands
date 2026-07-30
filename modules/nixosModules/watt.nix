{
  hosts = [
    "laptop"
    "server"
  ];
  config = {
    powerManagement.enable = true;
    services.watt = {
      enable = true;
      settings = {
      };
    };
  };
}
