{
  hosts = [ "vps" ];
  config = { config, ... }: {
    # secrets
    sops.secrets."mystuff/trJWT" = { };
    sops.secrets."mystuff/trDROP" = { };
    sops.secrets."mystuff/trKEY" = { };
    sops.secrets."mystuff/trTelegramBotKey" = { };
    sops.secrets."mystuff/trTelegramBotWebhook" = { };
    sops.templates."tranquil-pds-secrets".content = ''
      JWT_SECRET="${config.sops.placeholder."mystuff/trJWT"}"
      DPOP_SECRET="${config.sops.placeholder."mystuff/trDROP"}"
      MASTER_KEY="${config.sops.placeholder."mystuff/trKEY"}"
      TELEGRAM_BOT_TOKEN="${config.sops.placeholder."mystuff/trTelegramBotKey"}"
      TELEGRAM_WEBHOOK_SECRET="${config.sops.placeholder."mystuff/trTelegramBotWebhook"}"
    '';

    # Module
    services.tranquil-pds = {
      enable = true;
      database.createLocally = true; # don't wanna deal with postgress
      settings = {
        server = {
          hostname = "social.ladas552.me";
          age_assurance_override = true;
          disable_account_verification_gate = true;
          banned_words = [
            "emacs"
            "guix"
          ];
        };
      };
      environmentFiles = [
        config.sops.templates."tranquil-pds-secrets".path
      ];
    };

    # Reverse proxy
    services.caddy.virtualHosts."social.ladas552.me" = {
      extraConfig = ''
        handle {
          reverse_proxy localhost:3000
        }
      '';
    };

    # persist for Impermanence
    custom.imp.root.directories = [
      "/var/lib/tranquil-pds"
      "/var/lib/postgresql"
    ];
  };
}
