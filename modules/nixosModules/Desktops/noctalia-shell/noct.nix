{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config =
    {
      pkgs,
      lib,
      self,
      meta,
      ...
    }:
    {
      environment.systemPackages = [
        # disable idle on host that don't need it
        (self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia {
          extraSettings =
            if (meta.hostname == "NixOSu") then
              {
                idle.behavior = lib.mkForce {
                  lock.enabled = false;
                  lock-and-suspend.enabled = false;
                  screen-off.enabled = false;
                };
              }
            else
              {}:{};
        })
      ];

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".local/state/noctalia"
      ];
    };
}
