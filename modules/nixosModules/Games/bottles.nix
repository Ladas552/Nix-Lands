{
  enable = false;
  hosts = [
    "laptop"
  ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.bottles
      ];
      # persist games
      custom.imp.home.cache.directories = [
        ".local/share/bottles"
      ];
    };
}
