{
  config = {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [
      3030
    ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;
  };
}
