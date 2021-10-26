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
sudo parted -s /dev/sda -- mklabel gpt
sudo parted -s /dev/sda -- mkpart primary 512MiB -8GiB           # /home
sudo parted -s /dev/sda -- mkpart primary linux-swap -8GiB 100%  # swap
sudo parted -s /dev/sda -- mkpart ESP fat32 1MiB 512MiB          # /boot
sudo parted -s /dev/sda -- set 3 esp on

# Format the disks.
sudo mkfs.ext4 -F -L nixos /dev/sda1
sudo mkfs.fat -F 32 -n boot /dev/sda3

# Enable swap.
sudo mkswap -L swap /dev/sda2
sudo swapon /dev/sda2

# Mount the root partition.
sudo mount /dev/disk/by-label/nixos /mnt

# Mount the /boot partition.
sudo mkdir /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot

# Mount the nix configuration.
sudo mkdir /nix-config
sudo mount -t 9p -o trans=virtio /share /nix-config

# Boot a shell that has access to flakes + git.
nix-shell -p nixUnstable git

# Set up the minimal OS.
sudo nixos-install --flake /nix-config#vm-minimal

# Reboot!
sudo reboot now

# Log in as root and set up the full OS.
sudo mkdir /mnt
sudo nixos-rebuild --flake /nix-config#vm boot
sudo reboot now

# Log in as nickt via SSH and set a password.
sudo passwd nickt
```
