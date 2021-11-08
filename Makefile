NIXADDR ?= unknown
NIXPORT ?= 22
NIXUSER ?= nickt

NIXBLOCKDEVICE ?= sda

MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: ssh
ssh:
	ssh $(NIXUSER)@$(NIXADDR)

.PHONY: bootstrap
bootstrap:
	ssh root@$(NIXADDR) " \
		parted /dev/$(NIXBLOCKDEVICE) -- mklabel gpt; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary 512MiB -8GiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary linux-swap -8GiB 100\%; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart ESP fat32 1MiB 512MiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- set 3 esp on; \
		mkfs.ext4 -L nixos /dev/$(NIXBLOCKDEVICE)1; \
		mkswap -L swap /dev/$(NIXBLOCKDEVICE)2; \
		mkfs.fat -F 32 -n boot /dev/$(NIXBLOCKDEVICE)3; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed --in-place '/system\.stateVersion = .*/a \
			nix.package = pkgs.nixUnstable;\n \
			nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
  			services.openssh.enable = true;\n \
			services.openssh.passwordAuthentication = true;\n \
			services.openssh.permitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd; \
		reboot; \
	"

.PHONY: setup
setup:
	NIXUSER=root $(MAKE) vm/copy

.PHONY: copy
copy:
	rsync -av -e 'ssh -p$(NIXPORT)' \
		--exclude='.git/' \
		--exclude='*.swp' \
		--rsync-path="sudo rsync" \
		$(MAKEFILE_DIR)/ $(NIXUSER)@$(NIXADDR):/nix-config
