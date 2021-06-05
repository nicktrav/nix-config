=======
nix-home
========

# Testing with libvirt

Boot from the NixOS ISO, mounted as a USB.

Run through the following sequence of steps.

```bash
# Partition the disk.
$ sudo parted /dev/sda -- mklabel msdos
$ sudo parted /dev/sda -- mkpart primary 1MiB 5GiB             # /
$ sudo parted /dev/sda -- mkpart primary 5GiB -4GiB            # /home
$ sudo parted /dev/sda -- mkpart primary linux-swap -4GiB 100% # swap

# Format the disks.
$ mkfs.ext4 -L nixos /dev/sda1
$ mkfs.ext4 -L home /dev/sda2

# Enable swap.
$ mkswap -L swap /dev/sda3
$ swapon /dev/sda3

# Mount the root partition and generate a configuration.
$ mount /dev/disk/by-label/nixos /mnt
$ nixos-generate-config --root /mnt

# Boot a shell that has access to flakes + git.
$ nix-shell -p nixUnstable git

# Mount the nix configuration.
$ mkdir /nix-config
$ mount -t 9p -o trans=virtio /share /nix-config

# Set up the OS.
$ nixos-install --flake /nix-config#x1

# Reboot!
$ reboot
```
