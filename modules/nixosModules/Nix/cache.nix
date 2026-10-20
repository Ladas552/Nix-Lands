{
  config =
    { meta, ... }:
    {
      # Cache
      nix.settings = {
        trusted-users = [
          "root"
          "${meta.user}"
          "@wheel"
        ];
        substituters = [
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
        ];
        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://circus.ladas552.me/projects/Nix-Lands/nix-cache/"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "circus.ladas552.me-1:Zs4de2JNShhtJhjJTorpuEb+CLjth/xn8e9uNM1XBy4="
        ];
      };

    };
}
