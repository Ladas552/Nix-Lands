{
  hosts = [
    "pc"
    "laptop"
  ];
  config = { wrappers, ... }: {
    environment.systemPackages = [ wrappers.zathura.drv ];
    custom.imp.home.cache.directories = [
      ".local/share/zathura"
    ];
  };
}
