{
  hosts = [
    "server"
    "vps"
  ];
  config = { config, meta, ... }: {
    services.caddy = {
      enable = true;
      globalConfig = ''
        email me@ladas552.me
      '';
    };
    users.users."${meta.user}".extraGroups = [ "caddy" ];
    # stolen from @notthebe https://git.notthebe.ee/notthebee/nix-config/src/commit/03166ee6ee243c675ae4fbc43d9c06ae35ba0547/modules/homelab/services/default.nix#L68-L81
    security.acme = {
      acceptTerms = true;
      defaults.email = "me@ladas552.me";
      certs."ladas552.me" = {
        reloadServices = [ "caddy.service" ];
        domain = "ladas552.me";
        extraDomainNames = [ "*.ladas552.me" ];
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        dnsPropagationCheck = true;
        group = config.services.caddy.group;
        environmentFile = config.sops.templates."cloudflare-creds".path;
      };
    };
    # secrets
    sops.secrets."mystuff/cf-api" = { };
    sops.secrets."mystuff/cf-email" = { };
    sops.templates."cloudflare-creds".content = ''
      CF_DNS_API_TOKEN="${config.sops.placeholder."mystuff/cf-api"}"
      CF_API_EMAIL="${config.sops.placeholder."mystuff/cf-email"}"
    '';

    # Open firewall ports
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
