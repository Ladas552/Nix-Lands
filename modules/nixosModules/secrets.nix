{
  config =
    {
      pkgs,
      lib,
      meta,
      inputs,
      ...
    }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      environment.systemPackages = [ pkgs.sops ];

      sops.defaultSopsFile = ../../secrets/secrets.yaml;
      sops.defaultSopsFormat = "yaml";

      sops.age.sshKeyPaths = [
        "/persist/home/${meta.user}/.ssh/NixToks"
      ];
      sops.age.keyFile = lib.mkDefault "/persist/home/ladas552/.config/sops/age/keys.txt";

      sops.secrets."mystuff/host_pwd".neededForUsers = true;
      sops.secrets."mystuff/host_pwd" = { };

      # persist for Impermanence
      custom.imp.home.directories = [ ".config/sops/" ];
    };
}
