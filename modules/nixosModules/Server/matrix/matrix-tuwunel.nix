{
  # settings and well-known is stolen from @poz https://git.poz.pet/poz/niksos/src/commit/ca0170d49dcf01b9318e0eaaddf0a0e92aab5c74/hosts/szparag/services/conduit.nix
  # and @rysieko at https://tangled.org/did:plc:r6znfbtinv4yhwfpuxdsdvgn
  # To create user, enable registration with plain text token, rebuild, register,        disable registration, and rebuild. All without commiting changes to git.
  # Stupid system, but what can you do.
  hosts = [ "server" ];
  config = { config, ... }: {
    services.matrix-tuwunel = {
      enable = true;
      settings.global = {
        address = [ "0.0.0.0" ];
        server_name = "ladas552.me";
        port = [ 6161 ];
        max_request_size = 104857600;
        allow_registration = true;
        allow_federation = true;
        deprioritize_joins_through_servers = [
          "matrix.org"
        ];
        trusted_servers = [
          "codestorm.net"
          "starstruck.systems"
          "unredacted.org"
          "federated.nexus"
          "matrix.org"
        ];
        registration_token_file = config.secrets.matrix-tuwunel-token.path;
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 6161 ];

    # secrets
    secrets."matrix-tuwunel-token" = {
      owner = "tuwunel";
      mode = "400";
    };

    # persist for Impermanence
    system.nixos-core.persistence.stores."/persist".directories = [
      {
        target = "/var/lib/private/matrix-tuwunel";
        owner = "nobody";
        group = "nogroup";
      }
    ];
  };
}
