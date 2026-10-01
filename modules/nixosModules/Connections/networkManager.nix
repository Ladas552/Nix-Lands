{
  hosts = [
    "laptop"
    "iso"
  ];
  config = {
    networking.networkmanager.enable = true;
  };
}
