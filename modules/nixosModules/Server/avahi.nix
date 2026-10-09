{
# module to see hosts in local network as `hostname.local` withouth knowing their IP
  hosts = [ "pc" "server" "iso" ];
  config =
    {
      # stolen from https://github.com/ap-1/nixcfg/blob/3c4fd18c58388d2954295e0f5466964e3ac4fb23/modules/pc/sunshine.nix
      # Discovery, doesn't really work, I connect using tailscale
      services.avahi = {
        enable = true;
        openFirewall = true;
        nssmdns4 = true; # allows system to resolve .local addresses
        publish = {
          enable = true;
          userServices = true; # broadcasts services
          addresses = true; # broadcasts this machine's IP
        };
      };
    };
}
