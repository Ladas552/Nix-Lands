let
  # will create a folder with the bookmarks
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
]
