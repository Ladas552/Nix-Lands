# Highly experimental replacment to boot bash scripts with rust
{
  hosts = [
    "laptop"
    "server"
    "vps"
  ];
  config = { inputs, ... }: {
    imports = [ inputs.nixos-core.nixosModules.nixos-core ];
    system.nixos-core.enable = true;
  };
}
