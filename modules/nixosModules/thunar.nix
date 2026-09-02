{
  hosts = [
    "pc"
    "laptop"
    "iso"
  ];
  config =
    { pkgs, ... }:
    {
      programs.thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-volman
          thunar-archive-plugin
          thunar-media-tags-plugin
        ];
      };
      services = {
        gvfs.enable = true;
        tumbler.enable = true;
      };
      environment.systemPackages = [
        pkgs.ffmpegthumbnailer
        pkgs.bign-handheld-thumbnailer
      ];

      # fix opening terminal for nemo / thunar by using xdg-terminal-exec spec
      # xdg.terminal-exec = {
      #   enable = true;
      #   settings = {
      #     default = [ "${pkgs.ghostty}/share/applicatons/com.mitchellh.ghostty.desktop" ];
      #   };
      # };

      hj.xdg.config.files."Thunar/uca.xml".text = # xml
        ''
          <?xml version="1.0" encoding="UTF-8"?>
          <actions>
            <action>
              <icon>utilities-terminal</icon>
              <name>Open Terminal Here</name>
              <submenu></submenu>
              <unique-id>1734179588135391-1</unique-id>
              <command>cd %f &amp;&amp; "$TERMINAL"</command>
              <description>Example for a custom action</description>
              <range></range>
              <patterns>*</patterns>
              <startup-notify/>
              <directories/>
              </action>
            </actions>
        '';

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".local/share/gvfs-metadata"
        ".cache/thumbnails"
      ];
    };
}
