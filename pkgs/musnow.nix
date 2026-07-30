# I download songs with yt-dlp, and it embeds the url of the media into `comments` or `purl` tag, so i use ffmpeg to get the data to clipboard and share the media.

{ pkgs, ... }:
pkgs.writers.writeFishBin "musnow.sh" { } # fish
  ''
    #Dependencis
    #fish,ffmpeg,mpd,mpc
    #get current's song url into 'crtl+v' clipboard
    ffprobe -loglevel error -show_entries format_tags=purl -of default=noprint_wrappers=1:nokey=1 ~/Music/(mpc -f %file% current) | wl-copy
  ''
