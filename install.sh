#!/usr/bin/env bash
# Install script for zfs + tmpfs setup, run with sudo
set -euo pipefail
# idiot
read -rp "DID YOU GENERATE HARDWARE FILE? DUMBASS" confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
  echo "Proceeding..."
else
  echo "Aborted."
  exit 1
fi
# find a way to put keys for secrets into respective directories yourself
# My way is to `sudo passwd` a new root password and `ssh root@ip` into the vps
# Then just `scp ./keys.txt root@ip:/root`
echo "Wiping drives..."
# Wipe the NVMe
wipefs -a /dev/nvme0n1
sgdisk --zap-all /dev/nvme0n1

echo "Formatting drives..."
# Put boot on the NVMe then fill the rest with ZFS
sgdisk -n1:1M:+2G -t1:EF00 -c1:"NIXBOOT" /dev/nvme0n1
sgdisk -n2:0:+8G -t2:8200 -c2:"Linux Swap" /dev/nvme0n1
sgdisk -n3:0:0 -t3:BF01 -c3:"ZROOT" /dev/nvme0n1

# Format the boot partition
mkfs.vfat -n NIXBOOT -F32 /dev/nvme0n1p1

echo "Swap..."
# Swap
mkswap -L SWAP /dev/nvme0n1p2
swapon /dev/nvme0n1p2

echo "zpool creation..."
# Create the pool on the drive, use reasonable settings
zpool create -f \
  -o ashift=12 \
  -o autotrim=on \
  -O compression=zstd \
  -O acltype=posixacl \
  -O atime=off \
  -O xattr=sa \
  -O dnodesize=auto \
  -O normalization=formD \
  -O mountpoint=none \
  zroot "/dev/nvme0n1p3"

echo "mounting..."
# "Creating /", as this is an impermanence setup we don't actually need `/root`, but otherwise the whole system build will be on the usb flash drive and I don't have enough space for that. So we just create this temporary and remove it once we are booted into an actual system.
zfs create -o mountpoint=legacy zroot/root
mount -t zfs zroot/root /mnt

# Mount the drives and prepare for the install
mkdir -p /mnt/{cache,nix,persist,tmp,boot}
mount /dev/nvme0n1p1 /mnt/boot

# This create the zvols used in this cluster
for zvol in "tmp" "nix" "cache" "persist"; do
  zfs create -o mountpoint=legacy zroot/$zvol
  mount -t zfs zroot/$zvol /mnt/$zvol
done

echo "transfering secrets..."
mkdir -p /mnt/persist/home/ladas552/.ssh
mkdir -p /mnt/persist/home/ladas552/.config/sops/age
cp ./NixToks /mnt/persist/home/ladas552/.ssh/
cp ./keys.txt /mnt/persist/home/ladas552/.config/sops/age/

echo "installing..."
nixos-install --no-root-password --flake "github:Ladas552/Nix-Lands#NixBox"

