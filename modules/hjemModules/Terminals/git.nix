{
  config = {
    hj.rum.programs.git = {
      enable = true;
      # TODO no gh and openpgp integration like home-manager does, for now
      settings = {
        user = {
          name = "Ladas552";
          email = "me@ladas552.me";
          # chmod 400
          signingkey = "~/.ssh/NixToks";
        };
        init.defaultBranch = "master";
        gpg.format = "ssh";
        commit.gpgsign = true;
        aliases = {
          cm = "commit -m";
          al = "add ./*";
        };
      };
      ignore = ''
        .pre-commit-config.yaml
        result
        result-bin
        result-man
        target
        .direnv
        *.pdf
      '';
    };
  };
}
