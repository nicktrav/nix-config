{ config, lib, pkgs, ... }:

{
  imports = [
    ./readline.nix
  ];

  programs.bash = {
    enable = true;
    bashrcExtra =
      # TODO: work out how to add this environment variable.
      "export PKCS11_PATH=/usr/lib/x86_64-linux-gnu/opensc-pkcs11.so;" +
      builtins.readFile ./bashrc +
      builtins.readFile ./aliases +
      builtins.readFile ./prompt;
  };
}
