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
        inputs.mtv.multiverse.x86_64-linux.versions."zotero"."10.0.0"
      ];

      # Radeon
      # Enable OpenGL and hardware accelerated graphics drivers
      services.xserver.videoDrivers = [ "amdgpu" ];

      # latest mesa
      nix.settings = {
        extra-substituters = [ "https://nyx-cache.chaotic.cx/" ];
        extra-trusted-public-keys = [ "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk=" ];
      };

      hardware.graphics = {
        enable = true;
        package = inputs.nyx.packages.${pkgs.stdenv.hostPlatform.system}.mesa_git;
        enable32Bit = true;
        package32 = inputs.nyx.packages.${pkgs.stdenv.hostPlatform.system}.mesa32_git;
      };

      # Enable rocm
      # nixpkgs.config.rocmSupport = true;
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
