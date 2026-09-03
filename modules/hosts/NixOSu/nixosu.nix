{
  hosts = [ "pc" ];
  config =
    {
      pkgs,
      self,
      inputs,
      ...
    }:
    {
      _module.args = {
        meta = {
          hostname = "NixOSu";
          configPath = "/persist/home/ladas552/Projects/my_repos/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        blender
        libreoffice-stable
        shotcut
        imagemagick
        ffmpeg
        # ((inputs.mtv.multiverse.x86_64-linux.at "24.11")."ffmpeg")
        # gst_all_1.gst-libav
        # hunspell
        # hunspellDicts.en-us-large
        # hunspellDicts.ru-ru
        keepassxc
        self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate
        pwvucontrol
        qbittorrent
        telegram-desktop
        typst
        xarchiver
        zotero
        nvfetcher
        inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack
      ];

      # Radeon
      # Enable OpenGL and hardware accelerated graphics drivers
      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          vpl-gpu-rt
        ];
      };
      # Enable rocm
      nixpkgs.config.rocmSupport = true;
      hardware.amdgpu = {
        opencl.enable = true;
        initrd.enable = true;
      };
      system.stateVersion = "26.11"; # Did you read the comment?

      # persist my home on nixport to not interfere with server's /home
      custom.imp.home.directories = [
        "Share"
        "Pictures"
        "Projects"
        "Desktop"
        "Downloads"
        "Documents"
        "Videos"
        "Music"
        ".zotero"
        "Zotero"
        ".config/chromium"
      ];
    };
}
