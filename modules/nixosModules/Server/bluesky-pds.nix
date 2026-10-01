# bluesky social federation
# stolen from @SapphoSys https://github.com/SapphoSys/flake/blob/1d8ef92b389c467a83403cbaf7681352d7a53434/services/bluesky-pds/default.nix
{
  enable = false;
  hosts = [ "vps" ];
  config =
    { lib, config, ... }:
    {
      # secrets
      sops.secrets."mystuff/bluesky-pdsJWT" = { };
      sops.secrets."mystuff/bluesky-pdsADMIN" = { };
      sops.secrets."mystuff/bluesky-pdsKEY" = { };
      sops.templates."bluesky-pds-secrets".content = ''
        PDS_JWT_SECRET="${config.sops.placeholder."mystuff/bluesky-pdsJWT"}"
        PDS_ADMIN_PASSWORD="${config.sops.placeholder."mystuff/bluesky-pdsADMIN"}"
        PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX="${config.sops.placeholder."mystuff/bluesky-pdsKEY"}"
      '';

      # module
      services.bluesky-pds = {
        enable = true;
        goat.enable = true;
        pdsadmin.enable = true;
        settings = {
          PDS_HOSTNAME = "social.ladas552.me";
          PDS_PORT = 3000;
          PDS_BLOB_UPLOAD_LIMIT = "200000000"; # 200 MB
          PDS_CRAWLERS = lib.concatStringsSep "," [
            "https://bsky.network"
            "https://relay.cerulea.blue"
            "https://relay.upcloud.world"
            "https://atproto.africa"
          ];
        };
        environmentFiles = [
          config.sops.templates."bluesky-pds-secrets".path
        ];
      };

      # Reverse proxy
      services.caddy.virtualHosts."social.ladas552.me" = {
        extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:${toString config.services.bluesky-pds.settings.PDS_PORT}
          }
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/pds/" ];
    };
}
