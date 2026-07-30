{
  config =
    { lib, pkgs, ... }:
    {
      # SSH connections
      services.gnome.gnome-keyring.enable = true;
      security.pam = {
        services.login.enableGnomeKeyring = true;
        # Can use ssh instead of password on system
        sshAgentAuth.enable = true;
        services.sudo.sshAgentAuth = true;
      };
      # Makes my reboots hang on poweroff sometimes
      # services.sshguard.enable = true;

      programs.gnupg.agent = {
        enable = true;
        # enableSSHSupport = true;
      };

      # programs.ssh.startAgent = true;
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        openFirewall = true;
        startWhenNeeded = true;
        settings = {
          # Password because I can't connect my Tablet for some reason
          PasswordAuthentication = false;
          AllowUsers = null;
          UseDns = true;
          X11Forwarding = false;
          PermitRootLogin = lib.mkDefault "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
          Banner = "${pkgs.writeTextFile {
            name = "banner";
            text = "You shell not pass!";
          }}";
        };
      };

      # persist for Impermanence
      custom.imp = {
        # I don't know half of what these persists do, I stole them
        root.files = [
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];
        home.directories = [
          ".pki"
          ".ssh"
          ".local/share/.gnupg"
          ".local/share/keyrings"
        ];
      };
      hj.files.".ssh/config".text = ''
        Host aur.archlinux.org
          User aur
          IdentityFile ~/.ssh/aur

        Host github.com
          User Ladas552
          IdentityFile ~/.ssh/NixToks.pub

        Host *
          ForwardAgent yes
          ServerAliveInterval 0
          ServerAliveCountMax 3
          Compression no
          AddKeysToAgent yes
          HashKnownHosts no
          UserKnownHostsFile ~/.ssh/known_hosts
          ControlMaster auto
          ControlPath ~/.ssh/master-%r@%n:%p
          ControlPersist 10m
      '';
    };
}
