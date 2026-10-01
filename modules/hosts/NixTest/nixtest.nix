{
  hosts = [ "testing" ];
  config =
    { lib, ... }:
    {
      # host for testing random modules in isolated environment
      # created to test my fish wrapper
      _module.args = {
        meta = {
          hostname = "NixTest";
          configPath = "/persist/home/ladas552/Projects/my_repos/Nix-Lands";
          user = "ladas552";
        };
      };
      system.switch.enable = false;
      system.stateVersion = "26.11"; # Don't touch
      users.users.ladas552 = {
        # password is pass
        hashedPasswordFile = lib.mkForce null;
      };
    };
}
