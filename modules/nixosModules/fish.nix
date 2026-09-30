{
  config =
    {
      pkgs,
      config,
      wrappers,
      meta,
      ...
    }:
    {
      programs.fish = {
        enable = true;
        package = wrappers.fish.drv;
        shellAbbrs = config.environment.shellAliases;
      };
      environment = {
        systemPackages = with pkgs; [
          bat
          eza
          zoxide
          fzf
          bat
          btop
          fd
          ripgrep
          wiki-tui
          duf
          unimatrix
          wgetpaste
          bonk
          ripdrag
          wrappers.broot.drv
          wrappers.gcp
          wrappers.eval
        ];
        shellAliases = {
          # Better app names
          v = "nvim ./";
          # h = "hx";
          cd = "z";
          wiki = "wiki-tui";
          df = "duf";
          copypaste = "wgetpaste";
          cmatrix = "unimatrix -f -s 95";
          ls = "eza";
          # fastfetch = "fastfetch | ${lib.getExe pkgs.lolcat}";
          # Nix mantainense
          clean = "nh clean all";
          # yy = "nh os switch ${meta.configPath}";
          # yyy = "nh os boot ${meta.configPath}";
          yy = "nh os switch -t -f ${meta.configPath} nixosConfigurations.${meta.hostname}";
          yyy = "nh os boot -t -f ${meta.configPath} nixosConfigurations.${meta.hostname}";
          yy-flake = "nh os switch ${meta.configPath}";
          en = "cd ${meta.configPath} && nvim ./";
          eh = "cd ${meta.configPath} && nvim ./";
          # eh = "hx ${meta.configPath}";
          # en = "hx ${meta.configPath}";
          n = "ssh-add ~/.ssh/NixToks";
          # Git
          g = "git";
          gal = "git add ./*";
          gcm = "git commit -m";
          gpr = "git pull --rebase";
          gpu = "git push";
          # Neorg
          j = ''nvim -c "Neorg journal today"'';
          # directories
          mc = "br";
          mcv = "br ~/Videos";
          mcm = "br ~/Music";
          mcc = "br ~/.config/";
          mcp = "br ~/Pictures";
        };
        variables = {
          SHELL = "fish";
        };
      };

      custom.imp.home.cache = {
        files = [ ".bash_history" ];
        directories = [
          ".local/share/zoxide"
          ".local/share/fish"
        ];
      };
    };
}
