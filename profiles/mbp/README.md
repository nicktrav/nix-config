# Install


```bash
# Uninstall Nix, if present.
rm -rf /nix

# Install Nix.
_nix_version=2.3.14
cd /tmp
curl -o install-nix "https://releases.nixos.org/nix/$_nix_version/install"
sh ./install-nix
rm ./install-nix

# TODO(nickt): add the following to bash_profile / bashrc
#. /Users/nickt/.nix-profile/etc/profile.d/nix.sh

# Install nix-darwin.
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

# Install home-manager.
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
nix-channel --update

# Create a symlink to a new bash path.
sudo ln -sf /run/current-system/sw/bin/bash /usr/local/bin/bash

# Add a new shell to the list of available shells.
echo "/usr/local/bin/bash" >> /etc/shells

# Change the default shell to bash.
chsh -s /usr/local/bin/bash

# Switch to use the new configuration path.
darwin-rebuild switch \
  -I darwin-config=$HOME/Development/nix-config/profiles/mbp/darwin-configuration.nix
```
