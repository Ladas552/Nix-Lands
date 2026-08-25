# installation script for Hetzner VPS, I just loaded a standart nix iso in there
# Stolen from @Jet https://github.com/Michael-C-Buckley/nixos/blob/master/modules/hosts/o1/tools/format.sh

# find a way to put keys for secrets into respective directories yourself
# My way is to `sudo passwd` a new root password and `ssh root@ip` into the vps
# Then just `scp ./keys.txt root@ip:/root`

#!/usr/bin/env bash
set -euo pipefail

ZFS_OPTS="-o ashift=12 \
  -O compression=zstd \
  -O atime=off \
  -O xattr=sa \
  -O acltype=posixacl \
  -O dnodesize=auto \
  -O normalization=formD \
  -O mountpoint=none"

hostname="NixWool"

read -rp "This will erase the drives, as you sure? [y/N]" confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
  echo "Proceeding..."
else
  echo "Aborted."
  exit 1
fi

echo "Wiping drives..."
# Wipe the NVMe
wipefs -a /dev/sda
sgdisk --zap-all /dev/sda

echo "Formatting drives..."
# Put boot on the NVMe then fill the rest with ZFS
sgdisk -n1:1M:+512M -t1:EF00 -c1:"NIXBOOT" /dev/sda
sgdisk -n2:0:+4G -t2:8200 -c2:"Linux Swap" /dev/sda
sgdisk -n3:0:0 -t3:BF01 -c3:"ZROOT" /dev/sda

# Format the boot partition
mkfs.vfat -n NIXBOOT -F32 /dev/sda1

# Swap
mkswap -L SWAP /dev/sda2
swapon /dev/sda2

# Create the pool on the drive, use reasonable settings
echo "Creating zroot..."
zpool create -f $ZFS_OPTS zroot /dev/sda3

# Mount the drives and prepare for the install
mkdir -p /mnt
mkdir -p /mnt/{cache,nix,persist,tmp,boot}
mount /dev/sda1 /mnt/boot

# This create the zvols used in this cluster
for zvol in "tmp" "nix" "cache" "persist"; do
  zfs create -o mountpoint=legacy zroot/$zvol
  mount -t zfs zroot/$zvol /mnt/$zvol
done

mkdir -p /mnt/persist/home/ladas552/.ssh
mkdir -p /mnt/persist/home/ladas552/.config/sops/age
cp ./NixToks /mnt/persist/home/ladas552/.ssh/
cp ./keys.txt /mnt/persist/home/ladas552/.config/sops/age/

nixos-install --no-root-password --flake "github:Ladas552/Nixl-Lands#NixWool"

