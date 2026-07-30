{
  hosts = [ "laptop" ];
  config =
    { meta, ... }:
    {
      # module that makes nuphy.io site work for my nuphy AIRv3
      # Otherwise the site doesn't have access to nuphy firmware
      # Thanks goes to @jagerroni on NixOS discord
      services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", GROUP="hidraw", MODE="0660"
      '';
      users.groups.hidraw = { };
      users.users.${meta.user}.extraGroups = [ "hidraw" ];
    };
}
