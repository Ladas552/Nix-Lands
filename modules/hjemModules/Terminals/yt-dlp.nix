{
  hosts = [ "pc" "laptop" ];
  config =
    { pkgs, ... }:
    let
      videos = "~/Videos";
      music = "~/Music";
      aliases = {
        dl-video = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --output '%(title)s.%(ext)s'";
        dl-clips = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --ignore-errors --output '${videos}/clips/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s' --yes-playlist";
        dl-vocaloid = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${music}/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${music}/vocaloid/archive-file' --yes-playlist --max-filesize '20.0M'";
        dl-jpop = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${music}/jpop/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${music}/jpop/archive-file' --yes-playlist --max-filesize '20.0M'";
        dl-vocaloid-batch = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${music}/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${music}/vocaloid/archive-file' --yes-playlist --max-filesize '20.0M' --batch-file '${music}/vocaloid/batch-file'";
        dl-vocaloid-batch-utau-covers = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${music}/vocaloid/UTAU_covers/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${music}/vocaloid/archive-file' --yes-playlist --max-filesize '20.0M' --batch-file '${music}/vocaloid/batch-file-utau'";
      };
    in
    {
      environment = {
        systemPackages = [ pkgs.yt-dlp ];
        shellAliases = { } // aliases;
      };
    };
}
