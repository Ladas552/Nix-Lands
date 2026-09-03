{ types, ... }: {
  options = {
    nativeMessagingHosts = {
      type = types.listOf types.derivation;
      defaultFunc =
        { inputs }:
        let
          inherit (inputs.nixpkgs) pkgs;
        in
        [
          pkgs.keepassxc
          pkgs.ff2mpv
        ];
    };
    policies.default = {
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
      Preferences = {
        accessibility.typeaheadfind.flashBar = 0;
        browser.bookmarks.editDialog.confirmationHintShowCount = 3;
        browser.bookmarks.restore_default_bookmarks = false;
        browser.contentblocking.category = "strict";
        browser.display.use_document_fonts = 0;
        browser.dom.window.dump.enabled = false;
        browser.download.dir = "/home/ladas552/Downloads/Browser_Saves";
        browser.download.folderList = 2;
        browser.download.panel.shown = true;
        browser.download.viewableInternally.typeWasRegistered.avif = true;
        browser.download.viewableInternally.typeWasRegistered.webp = true;
        browser.eme.ui.firstContentShown = true;
        browser.engagement.ctrlTab.has-used = true;
        browser.engagement.downloads-button.has-used = true;
        browser.engagement.sidebar-button.has-used = true;
        browser.formfill.enable = true;
        browser.link.open_newwindow.override.external = 7;
        browser.ml.linkPreview.onboardingTimes = "";
        browser.newtabpage.pinned = "[{\"url\":\"https://github.com/\",\"baseDomain\":\"github.com\"},{\"url\":\"https://tangled.org\",\"label\":\"Tangled\"},{\"url\":\"https://rutracker.me\",\"label\":\"rutracker\"},{\"url\":\"https://www.southparkstudios.com/\"},{\"url\":\"https://hub.ladas552.me\",\"label\":\"Homepage\"},{\"url\":\"https://search.nixos.org/options\",\"label\":\"search.nixos\"},{\"url\":\"https://home-manager-options.extranix.com/?query=&release=master\",\"label\":\"Home Manager - Option Search\"}]";
        browser.newtabpage.storageVersion = 1;
        browser.newtabpage.activity-stream.showSponsored = false; # [FF58+] Sponsored stories
        browser.newtabpage.activity-stream.showSponsoredTopSites = false; # [FF83+] Sponsored shortcuts
        browser.newtabpage.activity-stream.showSponsoredCheckboxes = false; # [FF140+] Support Firefox
        browser.newtabpage.activity-stream.feeds.telemetry = false;
        browser.newtabpage.activity-stream.telemetry = false;
        browser.newtabpage.activity-stream.system.showWeather = false;
        browser.pageActions.persistedActions = "{\"ids\":[\"bookmark\"],\"idsInUrlbar\":[\"bookmark\"],\"idsInUrlbarPreProton\":[],\"version\":1}";
        browser.pagethumbnails.storage_version = 3;
        browser.policies.applied = true;
        browser.protections_panel.infoMessage.seen = true;
        browser.proton.toolbar.version = 3;
        browser.region.update.enabled = false;
        browser.safebrowsing.blockedURIs.enabled = true;
        browser.safebrowsing.downloads.enabled = true;
        browser.safebrowsing.downloads.remote.block_potentially_unwanted = false;
        browser.safebrowsing.downloads.remote.block_uncommon = false;
        browser.safebrowsing.downloads.remote.enabled = false;
        browser.safebrowsing.downloads.remote.url = "";
        browser.safebrowsing.malware.enabled = true;
        browser.safebrowsing.phishing.enabled = true;
        browser.safebrowsing.provider.google.gethashURL =
          "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2";
        browser.safebrowsing.provider.google.updateURL =
          "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%";
        browser.safebrowsing.provider.google4.dataSharingURL = "";
        browser.safebrowsing.provider.google4.gethashURL =
          "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        browser.safebrowsing.provider.google4.updateURL =
          "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        browser.safebrowsing.provider.mozilla.lastupdatetime = "1773980495180";
        browser.safebrowsing.provider.mozilla.nextupdatetime = "1774002095180";
        browser.search.suggest.enabled = true;
        browser.search.totalSearches = 100;
        browser.startup.couldRestoreSession.count = 1;
        browser.startup.page = 3;
        browser.tabs.inTitlebar = 0;
        browser.termsofuse.prefMigrationCheck = true;
        browser.theme.content-theme = 0;
        browser.theme.toolbar-theme = 0;
        browser.toolbarbuttons.introduced.sidebar-button = true;
        browser.translations.automaticallyPopup = false;
        browser.uiCustomization.horizontalTabsBackup = ''{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\"],\"currentVersion\":22,\"newElementCount\":2}'';
        browser.uiCustomization.horizontalTabstrip = "[\"tabbrowser-tabs\",\"new-tab-button\"]";
        browser.uiCustomization.navBarWhenVerticalTabs = "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"vpn_proton_ch-browser-action\"]";
        browser.uiCustomization.state = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"dearrow_ajay_app-browser-action\",\"addon_karakeep_app-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"ff2mpv_yossarian_net-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"simple-translate_sienori-browser-action\",\"_019f5290-6afb-4863-bc31-87cc0b6adb25_-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"vpn_proton_ch-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"ff2mpv_yossarian_net-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"simple-translate_sienori-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"zotero_chnm_gmu_edu-browser-action\",\"addon_karakeep_app-browser-action\",\"_019f5290-6afb-4863-bc31-87cc0b6adb25_-browser-action\",\"vpn_proton_ch-browser-action\",\"dearrow_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"TabsToolbar\",\"unified-extensions-area\",\"widget-overflow-fixed-list\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":6}";
        browser.urlbar.shortcuts.actions = false;
        browser.urlbar.showSearchSuggestionsFirst = false;
        browser.urlbar.suggest.quickactions = false;
        browser.urlbar.suggest.searches = true;
        browser.warnOnQuitShortcut = false;
        captchadetection.hasUnsubmittedData = false;
        devtools.cache.disabled = true;
        devtools.console.stdout.chrome = false;
        devtools.debugger.prefs-schema-version = 11;
        devtools.debugger.remote-enabled = false;
        dom.forms.autocomplete.formautofill = true;
        dom.security.https_only_mode = false;
        extensions.activeThemeID = "firefox-compact-dark@mozilla.org";
        extensions.blocklist.pingCountVersion = -1;
        extensions.colorway-builtin-themes-cleanup = 1;
        extensions.databaseSchema = 37;
        extensions.formautofill.addresses.enabled = true;
        extensions.getAddons.databaseSchema = 6;
        extensions.pendingOperations = false;
        extensions.pictureinpicture.enable_picture_in_picture_overrides = true;
        extensions.quarantinedDomains.list = "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br";
        extensions.signatureCheckpoint = 1;
        extensions.systemAddonSet = "{\"schema\":1,\"addons\":{}}";
        extensions.ui.dictionary.hidden = true;
        extensions.ui.extension.hidden = false;
        extensions.ui.locale.hidden = false;
        extensions.ui.sitepermission.hidden = true;
        extensions.webcompat.enable_interventions = true;
        extensions.webcompat.enable_shims = true;
        extensions.webcompat.perform_injections = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."addon@darkreader.org" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."addon@karakeep.app" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."deArrow@ajay.app" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."ff2mpv@yossarian.net" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."historyblock@kain" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."idcac-pub@guus.ninja" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."keepassxc-browser@keepassxc.org" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."languagetool-webextension@languagetool.org" =
          true;
        extensions.webextensions.ExtensionStorageIDB.migrated."simple-translate@sienori" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."sponsorBlocker@ajay.app" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."uBlock0@raymondhill.net" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."zotero@chnm.gmu.edu" = true;
        extensions.webextensions.ExtensionStorageIDB.migrated."{019f5290-6afb-4863-bc31-87cc0b6adb25}" =
          true;
        extensions.webextensions.ExtensionStorageIDB.migrated."{e75d9f2d-9270-4f16-94e1-abd73c5174f8}" =
          true;
        extensions.webextensions.uuids = "{\"formautofill@mozilla.org\":\"980c1e0e-ab71-4bc3-a286-2627320e0636\",\"newtab@mozilla.org\":\"044cd31c-adf9-452c-90e0-ab18c2495246\",\"pictureinpicture@mozilla.org\":\"d33039b7-b227-4df5-85f7-5028c7638bd4\",\"addons-search-detection@mozilla.com\":\"be0a5267-a18d-491c-9a55-b5dc7ef9de07\",\"webcompat@mozilla.org\":\"9a310967-e580-48bf-b3e8-4eafebbc122d\",\"default-theme@mozilla.org\":\"fc835dc6-97c2-481c-8a43-148ab67c6d11\",\"uBlock0@raymondhill.net\":\"c760efe1-98a0-429c-858d-cfb749fedfa1\",\"firefox-compact-dark@mozilla.org\":\"2a3dfe22-2e86-4d94-b577-8e73edcc5283\",\"firefox-alpenglow@mozilla.org\":\"a0e51c89-2ccb-4c5e-8d9f-11d6bc860720\",\"firefox-compact-light@mozilla.org\":\"1cbbedc6-bc41-4b40-96c2-86ce41cc4dde\",\"addon@darkreader.org\":\"5bf7882a-6882-4bc1-8858-64b6d54576db\",\"languagetool-webextension@languagetool.org\":\"a1c4ad5e-cfd3-4e0a-8226-8e0dac1f98e5\",\"{e75d9f2d-9270-4f16-94e1-abd73c5174f8}\":\"5631a119-64b7-4a5b-8ce1-e894c1425b46\",\"ff2mpv@yossarian.net\":\"cec430e4-fcb6-40e5-8ed2-2cc7d1850198\",\"historyblock@kain\":\"ad1cc8ab-f381-47de-b4c7-ff483fbccf1d\",\"idcac-pub@guus.ninja\":\"eeb539ef-0c6c-4f4c-a37a-3f6a7dc477eb\",\"keepassxc-browser@keepassxc.org\":\"ac97362d-0132-4c60-9285-5a487cb74b92\",\"simple-translate@sienori\":\"7bcf59fd-1488-4789-9db0-784818d0b9e9\",\"sponsorBlocker@ajay.app\":\"5491faa1-410c-4b62-a075-f26461aff927\",\"zotero@chnm.gmu.edu\":\"ceb6ab0f-5ebd-415a-b9b8-43ab160b85d8\",\"addon@karakeep.app\":\"6d075682-54df-4fd1-89b8-8cbaae1693ef\",\"ipp-activator@mozilla.com\":\"cf803264-c096-41ce-9848-8d8f1013ce97\",\"data-leak-blocker@mozilla.com\":\"655ef627-39dc-4e1a-a573-50c9a3c92971\",\"{019f5290-6afb-4863-bc31-87cc0b6adb25}\":\"9cc39d1c-ffb4-455a-b79f-82da59fd804f\",\"deArrow@ajay.app\":\"17b40f50-fce9-4a32-9991-59f488853bd5\"}";
        findbar.highlightAll = true;
        intl.accept_languages = "en-us,en,ru";
        intl.locale.requested = "en-US,ru";
        layout.css.prefers-color-scheme.content-override = 0;
        media.eme.enabled = true;
        media.videocontrols.picture-in-picture.video-toggle.enabled = false;
        media.webspeech.synth.dont_notify_on_error = true;
        network.captive-portal-service.enabled = false;
        network.connectivity-service.enabled = false;
        network.early-hints.preconnect.max_connections = 0;
        network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation = true;
        network.http.speculative-parallel-limit = 0;
        network.predictor.enabled = false;
        network.prefetch-next = false;
        pdfjs.enableAltTextForEnglish = true;
        pdfjs.enabledCache.state = false;
        pdfjs.enableScripting = false;
        permissions.delegation.enabled = false;
        permissions.manager.defaultsUrl = "";
        pref.browser.language.disable_button.down = false;
        pref.downloads.disable_button.edit_actions = false;
        pref.privacy.disable_button.tracking_protection_exceptions = false;
        pref.privacy.disable_button.view_passwords = false;
        pref.privacy.disable_button.view_passwords_exceptions = false;
        privacy.annotate_channels.strict_list.enabled = true;
        privacy.bounceTrackingProtection.hasMigratedUserActivationData = true;
        privacy.bounceTrackingProtection.mode = 1;
        privacy.clearOnShutdown_v2.cache = false;
        privacy.clearOnShutdown_v2.cookiesAndStorage = false;
        privacy.fingerprintingProtection = true;
        privacy.globalprivacycontrol.enabled = true;
        privacy.history.custom = true;
        privacy.purge_trackers.date_in_cookie_database = "0";
        privacy.query_stripping.enabled = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        privacy.resistFingerprinting = false;
        privacy.sanitize.sanitizeOnShutdown = false;
        privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs = true;
        privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings = true;
        privacy.trackingprotection.consentmanager.skip.pbmode.enabled = false;
        privacy.trackingprotection.emailtracking.enabled = true;
        privacy.trackingprotection.enabled = true;
        privacy.trackingprotection.socialtracking.enabled = true;
        security.disable_button.openCertManager = false;
        security.tls.enable_0rtt_data = false;
        services.sync.engine.addresses.available = true;
        sidebar.animation.duration-ms = 0;
        sidebar.animation.expand-on-hover.duration-ms = 0;
        sidebar.backupState = "{\"command\":\"\",\"panelOpen\":false,\"launcherWidth\":55,\"expandedLauncherWidth\":260,\"launcherExpanded\":false,\"launcherVisible\":true,\"pinnedTabsHeight\":0,\"collapsedPinnedTabsHeight\":0,\"toolsHeight\":40.55000305175781,\"collapsedToolsHeight\":40.55000305175781}";
        sidebar.main.tools = "history,bookmarks";
        sidebar.new-sidebar.has-used = true;
        sidebar.revamp = true;
        sidebar.verticalTabs = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        sidebar.visibility = "expand-on-hover";
        signon.autofillForms = true;
        signon.firefoxRelay.feature = "disabled";
        signon.generation.enabled = false;
        storage.vacuum.last.index = 2;
        toolkit.telemetry.reportingpolicy.firstRun = false;
        toolkit.winRegisterApplicationRestart = false;
        ui.key.menuAccessKeyFocuses = false;
        webchannel.allowObject.urlWhitelist = "";
        webgl.disabled = false;
        browser.aboutConfig.showWarning = false;
        geo.provider.use_geoclue = false;
        extensions.getAddons.showPane = false;
        browser.shell.checkDefaultBrowser = false;
        # arkenfox stuff= I could load in a fetched file, but don't wanna every option set in arkenfox
        extensions.htmlaboutaddons.recommendations.enabled = false;
        browser.discovery.enabled = false;
        app.shield.optoutstudies.enabled = false;
        app.normandy.enabled = false;
        app.normandy.api_url = "";
        browser.contentanalysis.enabled = false; # [FF121+] [DEFAULT: false]
        browser.contentanalysis.default_result = 0; # [FF127+] [DEFAULT: 0]
        privacy.spoof_english = 1;
        # block AI
        # https://askubuntu.com/questions/1556081/how-to-disable-all-the-ai-features-in-firefox-to-increase-performance
        browser.ml.enable = false;
        browser.ml.chat.enabled = false;
        browser.ml.chat.page = false;
        browser.ml.linkPreview.enabled = false;
        browser.tabs.groups.smart.enabled = false;
        browser.tabs.groups.smart.userEnabled = false;
        extensions.ml.enabled = false;
        sidebar.notification.badge.aichat = false;
        "browser.ml.chat.page.footerBadge" = false;
        "browser.ml.chat.page.menuBadge" = false;
        browser.ml.chat.menu = false;
        browser.ai.control.default = "blocked";
        browser.ai.control.linkPreviewKeyPoints = "blocked";
        browser.ai.control.pdfjsAltText = "blocked";
        browser.ai.control.sidebarChatbot = "blocked";
        browser.ai.control.smartTabGroups = "blocked";
        browser.ai.control.translations = "blocked";
      };
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) wrapFirefox;
      inherit (builtins) filter attrNames;
      filterNullAttrs = set: removeAttrs set (filter (name: isNull set.${name}) (attrNames set));
    in
    assert !(options ? policies && options ? policiesFiles);
    wrapFirefox options.package (filterNullAttrs {
      nativeMessagingHosts = options.nativeMessagingHosts or null;
      extraPolicies = options.policies or null;
      # From my testing, these options need to be coerced to store paths.
      # If you know of a workaround to allow impure paths to be used here,
      # please make a PR!
      extraPoliciesFiles =
        if options ? policiesFiles then map (file: "${file}") options.policiesFiles else null;
      extraPrefsFiles =
        if options ? autoConfigFiles then map (file: "${file}") options.autoConfigFiles else null;
    });

}
