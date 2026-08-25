{
  hosts = [ "laptop" ];
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
          hostname = "NixPort";
          configPath = "/persist/home/ladas552/Projects/my_repos/Nix-Lands";
          user = "ladas552";
        };
      };
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        # blender
        libreoffice-stable
        shotcut
        imagemagick
        wl-clipboard
        ffmpeg
        # ((inputs.mtv.multiverse.x86_64-linux.at "24.11")."ffmpeg")
        # gst_all_1.gst-libav
        # hunspell
        # hunspellDicts.en-us-large
        # hunspellDicts.ru-ru
        keepassxc
        self.packages.${pkgs.stdenv.hostPlatform.system}.libqalculate
        lshw
        zathura
        pamixer
        pwvucontrol
        yazi
        qbittorrent
        telegram-desktop
        typst
        xarchiver
        zotero
        nvfetcher
        inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack
      ];

      # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3#Display
      boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
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
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.11"; # Did you read the comment?

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
