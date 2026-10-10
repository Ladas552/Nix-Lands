{
  # stolen from @poacher
  # https://codeberg.org/poacher/nix-dotfiles/src/branch/master/wrappers/firefox
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
}
