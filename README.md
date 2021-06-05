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
$ sudo parted /dev/sda -- mklabel msdos
$ sudo parted /dev/sda -- mkpart primary 1MiB 30GiB            # /
$ sudo parted /dev/sda -- mkpart primary 30GiB -4GiB           # /home
$ sudo parted /dev/sda -- mkpart primary linux-swap -4GiB 100% # swap

# Format the disks.
$ mkfs.ext4 -L nixos /dev/sda1
$ mkfs.ext4 -L home /dev/sda2

# Enable swap.
$ mkswap -L swap /dev/sda3
$ swapon /dev/sda3

# Mount the root partition.
$ mount /dev/disk/by-label/nixos /mnt

# Boot a shell that has access to flakes + git.
$ nix-shell -p nixUnstable git

# Mount the nix configuration.
$ mkdir /nix-config
$ mount -t 9p -o trans=virtio /share /nix-config

# Set up the OS.
$ nixos-install --flake /nix-config#vm

# Reboot!
$ reboot

# Log in as root and set a password for the user.
$ passwd nickt
```
