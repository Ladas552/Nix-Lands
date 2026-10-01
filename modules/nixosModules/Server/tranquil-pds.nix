{
  hosts = [ "vps" ];
  config = { config, ... }: {
    # secrets
    secrets."trJWT" = { };
    secrets."trDROP" = { };
    secrets."trKEY" = { };
    secrets."trTelegramBotKey" = { };
    secrets."trTelegramBotWebhook" = { };
    security.nix-secrets.templates."tranquil-pds-secrets".content = ''
      JWT_SECRET="${config.secrets."trJWT"}"
      DPOP_SECRET="${config.secrets."trDROP"}"
      MASTER_KEY="${config.secrets."trKEY"}"
      TELEGRAM_BOT_TOKEN="${config.secrets."trTelegramBotKey"}"
      TELEGRAM_WEBHOOK_SECRET="${config.secrets."trTelegramBotWebhook"}"
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
        config.security.nix-secrets.templates."tranquil-pds-secrets".path
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
