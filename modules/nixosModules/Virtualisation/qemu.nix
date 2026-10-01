{
  enable = false;
  hosts = [ "laptop" ];
  config =
    { pkgs, meta, ... }:
    {
      # Wayroid
      # Delete images in `/var/lib/waydroid` after removing the option
      # virtualisation.waydroid.enable = true;
      environment.systemPackages = with pkgs; [
        open-vm-tools
        quickemu
        libvirt-glib
        # virt-viewer
        # spice
        # spice-gtk
        # spice-protocol
        #     win-virtio Deosn't work on my cpu
        # win-spice
      ];
      # Network Block Device (nbd) support.
      # https://cheatsheet.zwischenspeicher.info/2016/10/13-2016-10-14/
      programs.nbd.enable = true;
      #   boot.extraModprobeConfig = "options kvm_intel nested=1";
      services.spice-vdagentd.enable = true;
      programs.virt-manager.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          package = pkgs.qemu_kvm;
          # ovmf = {
          #   enable = true;
          #   packages = [(pkgs.OVMFFull.override {
          #     secureBoot = true;
          #     tpmSupport = true;
          #   })];
          # };
        };
      };
      users.users."${meta.user}".extraGroups = [ "libvirtd" ];

      # persist for Impermanence
      custom.imp.root.cache.directories = [ "/var/lib/libvirt" ];
    };
}
