{
  hosts = [ "laptop" ];
  config = {
    hj.rum.programs.chawan = {
      enable = true;
      settings = {
        buffer = {
          images = true;
          cookie = true;
          autofocus = true;
          history = false;
        };
        external = {
          copy-cmd = "wl-copy";
          paste-cmd = "wl-paste";
        };
        siteconf = {
          "ladas552.me" = {
            url = "https://ladas552.me/*";
            scripting = true;
          };
          "osu" = {
            url = "https://osu.ppy.sh/*";
            scripting = true;
          };
        };
        page = {
          "O" = "cmd.pager.load";
          "o" = "() => pager.load('ddg:')";
          ":" = "cmd.pager.enterCommand";
          "C-y" = "cmd.pager.copyURL";
          "yi" = "cmd.pager.copyCursorImage";
          "si" = "cmd.buffer.saveImage";
          "C-b" = "cmd.pager.openBookmarks";
          "C-a" = "cmd.pager.addBookmark";
        };
      };
    };
    # persist for Impermanence
    custom.imp.home.cache.files = [
      ".config/chawan/bookmark.md"
      ".config/chawan/history.uri"
    ];
  };
}
