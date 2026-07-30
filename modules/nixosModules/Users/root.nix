{
  config =
    { config, ... }:
    {
      # setup immutable users for impermanence
      users.users.root = {
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
      users.mutableUsers = false;
    };
}
