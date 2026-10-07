{
  hosts = [ "finix" ];
  config =
    {
      meta,
      pkgs,
      lib,
      inputs,
      ...
    }:
    {
      imports = [
        inputs.secrets.fenixModules.default
        (lib.mkAliasOptionModule [ "secrets" ] [ "security" "nix-secrets" "secrets" ])
      ];
      environment.systemPackages = [
        inputs.secrets.packages.${pkgs.stdenv.hostPlatform.system}.nix-secrets
      ];
      security.nix-secrets = {
        enable = true;
        extraPackages = [ pkgs.age ];
        storage = ../../secrets;
        storagePath = "${meta.configPath}/secrets"; # (copied to /nix/store)
        identityPaths = [
          "/persist/home/${meta.user}/.ssh/NixToks"
          "/persist/home/${meta.user}/.config/sops/age/keys.txt"
        ];
        recipientAliases = {
          ladas552 = "age18yaw2nreuzgmh2w9y2mpx7kmgfrwqzr6hf2raws0fk37ut950ydqwwctu8"; # Your age recipient (public key)
          ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPiFWLpIrKZ1+8PPSegYpNrRaPlE4t7iVUnHucvWQJJx"; # Or your SSH public key
        };
        defaultRecipients = [
          "ladas552"
          "ssh"
        ];
      };

      secrets."host_pwd".neededForUsers = true;

      # persist for Impermanence
      custom.imp.home.directories = [ ".config/sops/" ];
    };
}
