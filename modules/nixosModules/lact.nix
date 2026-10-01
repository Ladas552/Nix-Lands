{
  enable = false;
  hosts = [ "laptop" ];
  config = {
    # overclock your gpu. But I use it to underclock for greater battery life
    # Also makes my display stay turned on during suspend, idk man
    hardware.amdgpu.overdrive.enable = true;
    services.lact.enable = true;
  };
}
