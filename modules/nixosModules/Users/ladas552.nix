{
  config =
    { config, ... }:
    {
      users.users.ladas552 = {
        isNormalUser = true;
        description = "Ladas552";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIPiFWLpIrKZ1+8PPSegYpNrRaPlE4t7iVUnHucvWQJJx ladas552@NixPort"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPiFWLpIrKZ1+8PPSegYpNrRaPlE4t7iVUnHucvWQJJx ladas552@NixToks-2024-06-25"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOZaAO4vfV5kiLiHrrKTO8Y/YLVi72e/918YfWdgQBJ u0_a595@localhost"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEyzumytf6gU/PgXAqlKTMASUg3NJbdq4weMfnxZJmEG u0_a189@localhost"
        ];
      };
      nix.settings.trusted-users = [ "ladas552" ];
    };
}
