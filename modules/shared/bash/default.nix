{ config, lib, pkgs, ... }:

{
  imports = [
    ./readline.nix
  ];

  programs.bash = {
    enable = true;
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi'';
    bashrcExtra =
      builtins.readFile ./bashrc
      + builtins.readFile ./aliases
      + builtins.readFile ./prompt
      + ''
        export PKCS11_PATH=${pkgs.opensc}/lib/opensc-pkcs11.so
      '';
  };
}
