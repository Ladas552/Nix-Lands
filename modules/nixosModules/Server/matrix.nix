{
  # settings and well-known is stolen from @poz https://git.poz.pet/poz/niksos/src/commit/ca0170d49dcf01b9318e0eaaddf0a0e92aab5c74/hosts/szparag/services/conduit.nix
  # and @rysieko at https://tangled.org/did:plc:r6znfbtinv4yhwfpuxdsdvgn
  hosts = [ "vps" ];
  config = { config, ... }: {
    services.caddy.virtualHosts = {
      "matrix.ladas552.me".extraConfig = ''
        reverse_proxy /_matrix/* http://127.0.0.1:6161
      '';
      "ladas552.me".extraConfig = ''
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *

        respond /.well-known/matrix/server `{
            "m.server": "matrix.ladas552.me:443"
        }`
        respond /.well-known/matrix/client `{
            "m.homeserver": {
                "base_url": "https://matrix.ladas552.me"
            },
            "m.identity_server": {
                "base_url": "https://matrix.org"
            },
            "org.matrix.msc3575.proxy": {
                "url": "https://matrix.ladas552.me"
            }
        }`
      '';
    };

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
          "kami.boo"
          "amaanq.com"
          "codestorm.net"
          "starstruck.systems"
          "unredacted.org"
          "federated.nexus"
          "matrix.org"
          "nixos.org"
        ];
        registration_token_file = config.secrets.matrix-tuwunel-token.path;
      };
    };

    networking.firewall.allowedTCPPorts = [
      443
      6161
    ];

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
