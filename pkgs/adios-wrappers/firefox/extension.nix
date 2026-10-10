let
  mkExtension = name: {
    install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${name}/latest.xpi";
    installation_mode = "force_installed";
  };
in
{
  "uBlock0@raymondhill.net" = mkExtension "ublock-origin";
  "sponsorBlocker@ajay.app" = mkExtension "sponsorblock";
  "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = mkExtension "terms-of-service-didnt-read";
  "{6d85dea2-0fb4-4de3-9f8c-264bce9a2296}" = mkExtension "link-cleaner";
  "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = mkExtension "auto-tab-discard";
  "simple-translate@sienori" = mkExtension "simple-translate";
  "keepassxc-browser@keepassxc.org" = mkExtension "keepassxc-browser";
  "idcac-pub@guus.ninja" = mkExtension "istilldontcareaboutcookies";
  "addon@darkreader.org" = mkExtension "darkreader";
  "addon@karakeep.app" = mkExtension "karakeep";
  "deArrow@ajay.app" = mkExtension "dearrow";
  "ff2mpv@yossarian.net" = mkExtension "ff2mpv";
  "{e75d9f2d-9270-4f16-94e1-abd73c5174f8}" = mkExtension "deshiro";
  "zotero@chnm.gmu.edu" = {
    # not in mozzila store, so install directly from another site. It should auto download the latest version
    install_url = "https://www.zotero.org/download/connector/dl?browser=firefox";
    installation_mode = "force_installed";
  };
}
