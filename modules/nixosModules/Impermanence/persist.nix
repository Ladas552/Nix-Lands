# This file exists to not clutter other nixos module files with generic persists, like network manager. I will move all options below somewhere else before I finish impermanence setup
{
  config = {
    custom.imp = {
      root = {
        directories = [
          "/etc/NetworkManager"
          "/var/lib/NetworkManager"
          "/var/lib/iwd"
          "/var/lib/systemd/coredump"
        ];
        cache.files = [ "/etc/machine-id" ]; # to have systemd journal in the same file
      };
      home = {
        directories = [
          ".librewolf"
        ];
        cache = {
          files = [ ".local/share/com.jeffser.Alpaca/alpaca.db" ];
          directories = [
            ".local/share/Trash"
            ".local/share/qalculate"
            ".local/share/zathura"
            ".local/share/TelegramDesktop"
            ".local/share/nvim"
            ".local/state/nvim"
            ".local/state/nvf"
            ".local/share/nvf"
            ".config/libreoffice"
            ".cache/librewolf"
            ".cache/keepassxc"
            ".config/keepassxc"
            ".config/qBittorrent"
            ".config/Element"
            ".local/share/qBittorrent"
            ".cache/nix"
            ".cache/nix-index"
          ];
        };
      };
    };
  };
}
