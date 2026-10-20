{
  hosts = [ "server" ];
  config =
    { pkgs, ... }:
    {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_18;
      };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/postgresql"
      ];
    };
}
