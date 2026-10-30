{
  hosts = [
    "laptop"
    "iso"
  ];
  config = {
    networking.networkmanager.enable = true;
    custom.imp.root.directories = [
      "/etc/NetworkManager"
      "/var/lib/NetworkManager"
      "/var/lib/iwd"
    ];
  };
}
