{
  config =
    {
      lib,
      inputs,
      meta,
      ...
    }:
    {
      imports = [
        inputs.hjem.nixosModules.default
        (lib.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${meta.user}" ])
      ];
      hjem = {
        clobberByDefault = true;
        extraModules = [
          inputs.hjem-rum.hjemModules.default
        ];
        users.${meta.user} = {
          user = "${meta.user}";
          directory = "/home/${meta.user}";
          # If enabled, can't use home-manager service modules.
          systemd.enable = true;
          rum.environment.hideWarning = true;
        };
      };
    };
}
