=======
nix-home
========

# Testing with libvirt

Boot from the NixOS ISO, mounted as a USB.

Download the [latest ISO from
nixos.org](https://channels.nixos.org/nixos-21.05/latest-nixos-minimal-x86_64-linux.iso).

Build a VM using Virtual Machine Manager with the following additional devices
and settings:

- IDE Disk: 50 GiB
- USB Disk: use the downloaded NixOS ISO
- Filesystem share: map this repo to the target path `/share` in mode `Mapped`
- Set the following boot options:
    - Enable boot menu
    - Boot order: Disk, USB

Boot the VM and run through the following sequence of steps. It may be simpler
to set a password immediately on boot and SSH into the VM.

```bash
# Partition the disk.
sudo parted -s /dev/sda -- mklabel msdos
sudo parted -s /dev/sda -- mkpart primary 1MiB 30GiB            # /
sudo parted -s /dev/sda -- mkpart primary 30GiB -4GiB           # /home
sudo parted -s /dev/sda -- mkpart primary linux-swap -4GiB 100% # swap

# Format the disks.
sudo mkfs.ext4 -F -L nixos /dev/sda1
sudo mkfs.ext4 -F -L home /dev/sda2

# Enable swap.
sudo mkswap -L swap /dev/sda3
sudo swapon /dev/sda3

# Mount the root partition.
sudo mount /dev/disk/by-label/nixos /mnt

# Mount the nix configuration.
sudo mkdir /nix-config
sudo mount -t 9p -o trans=virtio /share /nix-config

# Boot a shell that has access to flakes + git.
nix-shell -p nixUnstable git

# Set up the OS.
sudo nixos-install --flake /nix-config#vm

# Reboot!
sudo reboot now

# Log in as root and set a password for the user.
sudo passwd nickt
```
