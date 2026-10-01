{
  config =
    { config, ... }:
    {
      # setup immutable users for impermanence
      users.users.root = {
        initialPassword = "pass";
        hashedPasswordFile = config.secrets."host_pwd".path;
      };
      users.mutableUsers = false;
    };
}
