{
  enable = false;
  hosts = [
    "laptop"
    "server"
  ];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.tinymist
        pkgs.typstyle
      ];
      hj.rum.programs.helix = {
        languages = {
          language-server.tinymist = {
            command = "tinymist";
            config = {
              capabilities.hoverProvider = false;
              exportPdf = "onType";
              outputPath = "$root/$name";
              typstExtraArgs = [ "src.typ" ];
              fontPaths = [ "./fonts" ];
              formatterMode = "typstyle";
            };
          };
          language = [
            {
              name = "typst";
              scope = "source.typ";
              injection-regex = "typ";
              file-types = [ "typ" ];
              comment-token = "//";
              language-servers = [ "tinymist" ];
            }
          ];
        };
      };
    };
}
