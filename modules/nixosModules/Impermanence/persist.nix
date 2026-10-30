# This file exists to not clutter other nixos module files with generic persists, like network manager. I will move all options below somewhere else before I finish impermanence setup
# /var/lib/nixos is essential for nixos to function, don't loose it
{
  config = {
    custom.imp = {
      root.directories = [
        "/var/lib/systemd/coredump"
        "/var/log"
        "/var/lib/nixos"
      ];
      home = {
        cache = {
          directories = [
            ".local/share/Trash"
            ".local/share/qalculate"
            ".local/share/TelegramDesktop"
            ".config/libreoffice"
            ".cache/keepassxc"
            ".config/keepassxc"
            ".config/qBittorrent"
            ".config/Element"
            ".local/share/qBittorrent"
          ];
        };
      };
    };
  };
}
