{ inputs, pkgs, ... }:
let
  adios = import "${inputs.adios}/adios";

  # Nixpkgs module
  nixpkgsModule = adios: {
    name = "nixpkgs";
    options = {
      pkgs = {
        type = adios.types.attrs;
      };
      lib = {
        type = adios.types.attrs;
        defaultFunc = { options }: options.pkgs.lib;
      };
    };
  };

  # Create tree by calling adios with root module definition then options
  tree =
    adios
      {
        name = "root";
        modules = {
          nixpkgs = nixpkgsModule adios;
          wrapAdifox = import "${inputs.adifox}/wrapAdifox.nix" adios;
        };
      }
      {
        options = {
          "/nixpkgs" = { inherit pkgs; };
        };
      };
  firefox = tree.modules.wrapAdifox {
    package = pkgs.firefox-unwrapped;
    nativeMessagingHosts = with pkgs; [
      keepassxc
      ff2mpv
    ];
    extraPolicies = {
      # will create a folder with the bookmarks
      ManagedBookmarks =
        let
          # mkBookmark
          b = name: url: {
            inherit name;
            url = "https://${url}";
          };
          # mkFolder
          f = name: children: { inherit name children; };
        in
        [
          { "toplevel_name" = "Declared Bookmarks"; }
          (f "Сантехник" [
            (b "Hetzner" "console.hetzner.com")
            (b "Tailscale" "login.tailscale.com/admin/machines")
            (b "Cloudflare" "dash.cloudflare.com")
          ])
          (f "Материалы для Учебы" [
            (f "Статьи" [
              (b "PubMed для статей" "pubmed.ncbi.nlm.nih.gov")
              (b "Anna’s Archive" "annas-archive.gl")
              (b "Shihub" "sci-hub.pub")
              (b "Русская Литература PDF" "a4format.ru")
              (b "Zotero Bib generator" "zbib.org")
              (b "Academic Torrents" "academictorrents.com")
              (b "Zotero Library" "zotero.org/ladas552/library")
              (b "Google Scholar" "scholar.google.com")
            ])
            (b "NCBI для генов и белков" "ncbi.nlm.nih.gov")
            (b "Biology Dictionary" "biologydictionary.net")
            (b "Biology Library" "bio.libretexts.org")
            (b "PubChem" "pubchem.ncbi.nlm.nih.gov")
            (f "Bioinformatics" [
              (b "Primer3" "pubchem.ncbi.nlm.nih.gov")
              (b "Oligo Analyzer" "idtdna.com/pages/tools/oligoanalyzer")
              (b "Rosie2 Разные Инструменты" "r2.graylab.jhu.edu")
            ])
            (b "Калькуляторы" "molbiol.ru/eng/scripts/index.html")
            (b "Stanford Medicine" "stanfordhealthcare.org")
            (b "Real Time PCR guides" "gene-quantification.de/main-bioinf.shtml")
          ])
          (f "Социопат" [
            (b "Gmail" "mail.google.com/mail/u/0/#inbox")
            (b "Blog" "blog.ladas552.me")
            (b "Nix Blog" "nix.ladas552.me")
            (b "Tangled" "tangled.org")
            (b "Github" "github.com/Ladas552")
            (b "OSU!" "osu.ppy.sh/users/22649018")
            (b "Bluesky" "bsky.app")
            (b "Instagram" "instagram.com/ladas553")
            (b "Shikimori" "shikimori.io/Ladas552")
          ])
          (f "Картинки и Комиксы" [
            (b "Loading Artist" "loadingartist.com")
            (b "xkcd" "xkcd.com")
            (b "Danbooru" "danbooru.donmai.us")
            (b "Konachan" "konachan.net/post")
            (b "Pixiv" "pixiv.net/en")
            (b "Wallpaper Flare" "wallpaperflare.com")
            (b "Wallhaven" "wallhaven.cc")
          ])
          (f "Игры" [
            (b "EpicGames" "store.epicgames.com")
            (b "Steam" "store.steampowered.com")
            (b "AD Spreadsheet" "docs.google.com/spreadsheets/d/1NrYADsW4s7wRYTE91Z0EFHbXcHaswuuMzG9a2WyGG0A")
            (f "OSU!" [
              (b "you suck at streaming" "ckrisirkc.github.io/osuStreamSpeed.js/newindex.html")
              (b "Osu Achivments" "inex.osekai.net/medals")
            ])
            (b "Mahjong Soul" "mahjongsoul.game.yo-star.com")
          ])
          (f "Анимешник чертов" [
            (f "Визуальные Новеллы" [
              (b "Visual Novel Database" "vndb.org")
              (b "Anivisual ВН на русском" "anivisual.net")
            ])
            (f "Vocaloid" [
              (b "Vocaloid DB" "vocadb.net")
              (b "Vocaloid News заброшен с 2021" "vocaloidnews.net")
              (b "MikuPA русский воколоидный новостник" "mikupa.ru/vocaloids")
              (b "Chimera Album" "chimera12.com")
            ])
            (b "Lucky Star Drama CD Translations" "heavens-feel.com/luckystardramacdtranslation_part1.html")
            (b "Typesetting Anime Guide" "unanimated.github.io/ts/ts-basics.htm")
          ])
          (f "Music" [
            (f "Radio" [
              (b "r/a/dio" "r-a-d.io")
              (b "Touhou Radio" "gensokyoradio.net/playing")
              (b "Radio of Touhou tracks from Nyaa.si" "iconradio.stream.laut.fm")
            ])
          ])
          (f "Разное" [
            (b "tldraw" "tldraw.com")
            (b "Make Ascii Banners" "patorjk.com/software/taag")
            (b "Convertion tools" "inettools.net")
            (f "Nix-Tools" [
              (b "Nix-evaluator-stats" "notashelf.github.io/nix-evaluator-stats")
            ])
          ])
        ];
      # stolen from @heisfer
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      PopupBlocking = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      # stolen from @poacher
      # https://codeberg.org/poacher/nix-dotfiles/src/branch/master/wrappers/firefox
      SearchEngines = {
        Remove = [
          "DuckDuckGo"
          "Bing"
          "eBay"
          "Amazon.com"
          "Wikipedia (en)"
          "Google"
          "Perplexity"
        ];
        Default = "Searxng";
        Add = [
          {
            Name = "Searxng";
            URLTemplate = "https://searxng.ladas552.me/search?q={searchTerms}";
          }
          {
            Name = "Noogle";
            URLTemplate = "https://noogle.dev/q?term={searchTerms}";
            IconURL = "https://noogle.dev/favicon.png";
            Alias = "@ng";
          }
          {
            Name = "Nixpkgs";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&size=100&query={searchTerms}";
            Alias = "@np";
          }
          {
            Name = "Home Manager Options";
            URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
            IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
            Alias = "@hm";
          }
          {
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?channel=unstable&size=100&query={searchTerms}";
            Alias = "@no";
          }
        ];
      };
      ExtensionSettings =
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
          "languagetool-webextension@languagetool.org" = mkExtension "languagetool";
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
        };

    };
    extraPrefs = # js
      ''
        pref("accessibility.typeaheadfind.flashBar", 0);
        pref("browser.bookmarks.editDialog.confirmationHintShowCount", 3);
        pref("browser.bookmarks.restore_default_bookmarks", false);
        pref("browser.contentblocking.category", "strict");
        pref("browser.display.use_document_fonts", 0);
        pref("browser.dom.window.dump.enabled", false);
        pref("browser.download.dir", "/home/ladas552/Downloads/Browser_Saves");
        pref("browser.download.folderList", 2);
        pref("browser.download.panel.shown", true);
        pref("browser.download.viewableInternally.typeWasRegistered.avif", true);
        pref("browser.download.viewableInternally.typeWasRegistered.webp", true);
        pref("browser.eme.ui.firstContentShown", true);
        pref("browser.engagement.ctrlTab.has-used", true);
        pref("browser.engagement.downloads-button.has-used", true);
        pref("browser.engagement.sidebar-button.has-used", true);
        pref("browser.formfill.enable", true);
        pref("browser.link.open_newwindow.override.external", 7);
        pref("browser.ml.enable", false);
        pref("browser.ml.linkPreview.onboardingTimes", "");
        pref("browser.newtabpage.pinned", "[{\"url\":\"https://github.com/\",\"baseDomain\":\"github.com\"},{\"url\":\"https://tangled.org\",\"label\":\"Tangled\"},{\"url\":\"https://rutracker.me\",\"label\":\"rutracker\"},{\"url\":\"https://www.southparkstudios.com/\"},{\"url\":\"https://hub.ladas552.me\",\"label\":\"Homepage\"},{\"url\":\"https://search.nixos.org/options\",\"label\":\"search.nixos\"},{\"url\":\"https://home-manager-options.extranix.com/?query=&release=master\",\"label\":\"Home Manager - Option Search\"}]");
        pref("browser.newtabpage.storageVersion", 1);
        pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+] Sponsored stories
        pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Sponsored shortcuts
        pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false); // [FF140+] Support Firefox
        pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
        pref("browser.newtabpage.activity-stream.telemetry", false);
        pref("browser.newtabpage.activity-stream.system.showWeather", false);
        pref("browser.pageActions.persistedActions", "{\"ids\":[\"bookmark\"],\"idsInUrlbar\":[\"bookmark\"],\"idsInUrlbarPreProton\":[],\"version\":1}");
        pref("browser.pagethumbnails.storage_version", 3);
        pref("browser.policies.applied", true);
        pref("browser.protections_panel.infoMessage.seen", true);
        pref("browser.proton.toolbar.version", 3);
        pref("browser.region.update.enabled", false);
        pref("browser.safebrowsing.blockedURIs.enabled", true);
        pref("browser.safebrowsing.downloads.enabled", true);
        pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
        pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
        pref("browser.safebrowsing.downloads.remote.enabled", false);
        pref("browser.safebrowsing.downloads.remote.url", "");
        pref("browser.safebrowsing.malware.enabled", true);
        pref("browser.safebrowsing.phishing.enabled", true);
        pref("browser.safebrowsing.provider.google.gethashURL", "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2");
        pref("browser.safebrowsing.provider.google.updateURL", "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%");
        pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
        pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
        pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
        pref("browser.safebrowsing.provider.mozilla.lastupdatetime", "1773980495180");
        pref("browser.safebrowsing.provider.mozilla.nextupdatetime", "1774002095180");
        pref("browser.search.suggest.enabled", true);
        pref("browser.search.totalSearches", 100);
        pref("browser.startup.couldRestoreSession.count", 1);
        pref("browser.startup.page", 3);
        pref("browser.tabs.inTitlebar", 0);
        pref("browser.termsofuse.prefMigrationCheck", true);
        pref("browser.theme.content-theme", 0);
        pref("browser.theme.toolbar-theme", 0);
        pref("browser.toolbarbuttons.introduced.sidebar-button", true);
        pref("browser.translations.automaticallyPopup", false);
        pref("browser.uiCustomization.horizontalTabsBackup", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\"],\"currentVersion\":22,\"newElementCount\":2}");
        pref("browser.uiCustomization.horizontalTabstrip", "[\"tabbrowser-tabs\",\"new-tab-button\"]");
        pref("browser.uiCustomization.navBarWhenVerticalTabs", "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"vpn_proton_ch-browser-action\"]");
        pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"dearrow_ajay_app-browser-action\",\"addon_karakeep_app-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"ff2mpv_yossarian_net-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"simple-translate_sienori-browser-action\",\"_019f5290-6afb-4863-bc31-87cc0b6adb25_-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"vpn_proton_ch-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"ff2mpv_yossarian_net-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"simple-translate_sienori-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"addon_karakeep_app-browser-action\",\"_019f5290-6afb-4863-bc31-87cc0b6adb25_-browser-action\",\"vpn_proton_ch-browser-action\",\"dearrow_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"TabsToolbar\",\"unified-extensions-area\",\"widget-overflow-fixed-list\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":6}");
        pref("browser.urlbar.shortcuts.actions", false);
        pref("browser.urlbar.showSearchSuggestionsFirst", false);
        pref("browser.urlbar.suggest.quickactions", false);
        pref("browser.urlbar.suggest.searches", true);
        pref("browser.warnOnQuitShortcut", false);
        pref("captchadetection.hasUnsubmittedData", false);
        pref("devtools.cache.disabled", true);
        pref("devtools.console.stdout.chrome", false);
        pref("devtools.debugger.prefs-schema-version", 11);
        pref("devtools.debugger.remote-enabled", false);
        pref("dom.forms.autocomplete.formautofill", true);
        pref("dom.security.https_only_mode", false);
        pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
        pref("extensions.blocklist.pingCountVersion", -1);
        pref("extensions.colorway-builtin-themes-cleanup", 1);
        pref("extensions.databaseSchema", 37);
        pref("extensions.formautofill.addresses.enabled", true);
        pref("extensions.getAddons.databaseSchema", 6);
        pref("extensions.pendingOperations", false);
        pref("extensions.pictureinpicture.enable_picture_in_picture_overrides", true);
        pref("extensions.quarantinedDomains.list", "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br");
        pref("extensions.signatureCheckpoint", 1);
        pref("extensions.systemAddonSet", "{\"schema\":1,\"addons\":{}}");
        pref("extensions.ui.dictionary.hidden", true);
        pref("extensions.ui.extension.hidden", false);
        pref("extensions.ui.locale.hidden", false);
        pref("extensions.ui.sitepermission.hidden", true);
        pref("extensions.webcompat.enable_interventions", true);
        pref("extensions.webcompat.enable_shims", true);
        pref("extensions.webcompat.perform_injections", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.addon@darkreader.org", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.addon@karakeep.app", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.deArrow@ajay.app", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.ff2mpv@yossarian.net", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.historyblock@kain", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.idcac-pub@guus.ninja", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.keepassxc-browser@keepassxc.org", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.languagetool-webextension@languagetool.org", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.simple-translate@sienori", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.sponsorBlocker@ajay.app", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.uBlock0@raymondhill.net", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.zotero@chnm.gmu.edu", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.{019f5290-6afb-4863-bc31-87cc0b6adb25}", true);
        pref("extensions.webextensions.ExtensionStorageIDB.migrated.{e75d9f2d-9270-4f16-94e1-abd73c5174f8}", true);
        pref("extensions.webextensions.uuids", "{\"formautofill@mozilla.org\":\"980c1e0e-ab71-4bc3-a286-2627320e0636\",\"newtab@mozilla.org\":\"044cd31c-adf9-452c-90e0-ab18c2495246\",\"pictureinpicture@mozilla.org\":\"d33039b7-b227-4df5-85f7-5028c7638bd4\",\"addons-search-detection@mozilla.com\":\"be0a5267-a18d-491c-9a55-b5dc7ef9de07\",\"webcompat@mozilla.org\":\"9a310967-e580-48bf-b3e8-4eafebbc122d\",\"default-theme@mozilla.org\":\"fc835dc6-97c2-481c-8a43-148ab67c6d11\",\"uBlock0@raymondhill.net\":\"c760efe1-98a0-429c-858d-cfb749fedfa1\",\"firefox-compact-dark@mozilla.org\":\"2a3dfe22-2e86-4d94-b577-8e73edcc5283\",\"firefox-alpenglow@mozilla.org\":\"a0e51c89-2ccb-4c5e-8d9f-11d6bc860720\",\"firefox-compact-light@mozilla.org\":\"1cbbedc6-bc41-4b40-96c2-86ce41cc4dde\",\"addon@darkreader.org\":\"5bf7882a-6882-4bc1-8858-64b6d54576db\",\"languagetool-webextension@languagetool.org\":\"a1c4ad5e-cfd3-4e0a-8226-8e0dac1f98e5\",\"{e75d9f2d-9270-4f16-94e1-abd73c5174f8}\":\"5631a119-64b7-4a5b-8ce1-e894c1425b46\",\"ff2mpv@yossarian.net\":\"cec430e4-fcb6-40e5-8ed2-2cc7d1850198\",\"historyblock@kain\":\"ad1cc8ab-f381-47de-b4c7-ff483fbccf1d\",\"idcac-pub@guus.ninja\":\"eeb539ef-0c6c-4f4c-a37a-3f6a7dc477eb\",\"keepassxc-browser@keepassxc.org\":\"ac97362d-0132-4c60-9285-5a487cb74b92\",\"simple-translate@sienori\":\"7bcf59fd-1488-4789-9db0-784818d0b9e9\",\"sponsorBlocker@ajay.app\":\"5491faa1-410c-4b62-a075-f26461aff927\",\"zotero@chnm.gmu.edu\":\"ceb6ab0f-5ebd-415a-b9b8-43ab160b85d8\",\"addon@karakeep.app\":\"6d075682-54df-4fd1-89b8-8cbaae1693ef\",\"ipp-activator@mozilla.com\":\"cf803264-c096-41ce-9848-8d8f1013ce97\",\"data-leak-blocker@mozilla.com\":\"655ef627-39dc-4e1a-a573-50c9a3c92971\",\"{019f5290-6afb-4863-bc31-87cc0b6adb25}\":\"9cc39d1c-ffb4-455a-b79f-82da59fd804f\",\"deArrow@ajay.app\":\"17b40f50-fce9-4a32-9991-59f488853bd5\"}");
        pref("findbar.highlightAll", true);
        pref("intl.accept_languages", "en-us,en,ru");
        pref("intl.locale.requested", "en-US,ru");
        pref("layout.css.prefers-color-scheme.content-override", 0);
        pref("media.eme.enabled", true);
        pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
        pref("media.webspeech.synth.dont_notify_on_error", true);
        pref("network.captive-portal-service.enabled", false);
        pref("network.connectivity-service.enabled", false);
        pref("network.early-hints.preconnect.max_connections", 0);
        pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
        pref("network.http.speculative-parallel-limit", 0);
        pref("network.predictor.enabled", false);
        pref("network.prefetch-next", false);
        pref("pdfjs.enableAltTextForEnglish", true);
        pref("pdfjs.enabledCache.state", false);
        pref("pdfjs.enableScripting", false);
        pref("permissions.delegation.enabled", false);
        pref("permissions.manager.defaultsUrl", "");
        pref("pref.browser.language.disable_button.down", false);
        pref("pref.downloads.disable_button.edit_actions", false);
        pref("pref.privacy.disable_button.tracking_protection_exceptions", false);
        pref("pref.privacy.disable_button.view_passwords", false);
        pref("pref.privacy.disable_button.view_passwords_exceptions", false);
        pref("privacy.annotate_channels.strict_list.enabled", true);
        pref("privacy.bounceTrackingProtection.hasMigratedUserActivationData", true);
        pref("privacy.bounceTrackingProtection.mode", 1);
        pref("privacy.clearOnShutdown_v2.cache", false);
        pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);
        pref("privacy.fingerprintingProtection", true);
        pref("privacy.globalprivacycontrol.enabled", true);
        pref("privacy.history.custom", true);
        pref("privacy.purge_trackers.date_in_cookie_database", "0");
        pref("privacy.query_stripping.enabled", true);
        pref("privacy.query_stripping.enabled.pbmode", true);
        pref("privacy.resistFingerprinting", false);
        pref("privacy.sanitize.sanitizeOnShutdown", false);
        pref("privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs", true);
        pref("privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings", true);
        pref("privacy.trackingprotection.consentmanager.skip.pbmode.enabled", false);
        pref("privacy.trackingprotection.emailtracking.enabled", true);
        pref("privacy.trackingprotection.enabled", true);
        pref("privacy.trackingprotection.socialtracking.enabled", true);
        pref("security.disable_button.openCertManager", false);
        pref("security.tls.enable_0rtt_data", false);
        pref("services.sync.engine.addresses.available", true);
        pref("sidebar.animation.duration-ms", 0);
        pref("sidebar.animation.expand-on-hover.duration-ms", 0);
        pref("sidebar.backupState", "{\"command\":\"\",\"panelOpen\":false,\"launcherWidth\":55,\"expandedLauncherWidth\":260,\"launcherExpanded\":false,\"launcherVisible\":true,\"pinnedTabsHeight\":0,\"collapsedPinnedTabsHeight\":0,\"toolsHeight\":40.55000305175781,\"collapsedToolsHeight\":40.55000305175781}");
        pref("sidebar.main.tools", "history,bookmarks");
        pref("sidebar.new-sidebar.has-used", true);
        pref("sidebar.revamp", true);
        pref("sidebar.verticalTabs", true);
        pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
        pref("sidebar.visibility", "expand-on-hover");
        pref("signon.autofillForms", true);
        pref("signon.firefoxRelay.feature", "disabled");
        pref("signon.generation.enabled", false);
        pref("storage.vacuum.last.index", 2);
        pref("toolkit.telemetry.reportingpolicy.firstRun", false);
        pref("toolkit.winRegisterApplicationRestart", false);
        pref("ui.key.menuAccessKeyFocuses", false);
        pref("webchannel.allowObject.urlWhitelist", "");
        pref("webgl.disabled", false);
        pref("browser.aboutConfig.showWarning", false);
        pref("geo.provider.use_geoclue", false);
        pref("extensions.getAddons.showPane", false);
        pref("browser.shell.checkDefaultBrowser", false);
        // arkenfox stuff, I could load in a fetched file, but don't wanna every option set in arkenfox
        pref("extensions.htmlaboutaddons.recommendations.enabled", false);
        pref("browser.discovery.enabled", false);
        pref("app.shield.optoutstudies.enabled", false);
        pref("app.normandy.enabled", false);
        pref("app.normandy.api_url", "");
        pref("browser.contentanalysis.enabled", false); // [FF121+] [DEFAULT: false]
        pref("browser.contentanalysis.default_result", 0); // [FF127+] [DEFAULT: 0]
        pref("privacy.spoof_english", 1);
        // block AI
        // https://askubuntu.com/questions/1556081/how-to-disable-all-the-ai-features-in-firefox-to-increase-performance
        pref("browser.ml.enable", false);
        pref("browser.ml.chat.enabled", false);
        pref("browser.ml.chat.page", false);
        pref("browser.ml.linkPreview.enabled", false);
        pref("browser.tabs.groups.smart.enabled", false);
        pref("browser.tabs.groups.smart.userEnabled", false);
        pref("extensions.ml.enabled", false);
        pref("sidebar.notification.badge.aichat", false);
        pref("browser.ml.chat.page.footerBadge", false);
        pref("browser.ml.chat.page.menuBadge", false);
        pref("browser.ml.chat.menu", false);
        pref("browser.ai.control.default", "blocked");
        pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
        pref("browser.ai.control.pdfjsAltText", "blocked");
        pref("browser.ai.control.sidebarChatbot", "blocked");
        pref("browser.ai.control.smartTabGroups", "blocked");
        pref("browser.ai.control.translations", "blocked");
      '';
  };
in

firefox
