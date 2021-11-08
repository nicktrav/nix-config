{ config, pkgs, ... }:

{
  programs.bash = {
    sessionVariables = {
      PKCS11_PATH="${pkgs.opensc}/lib/opensc-pkcs11.so";
    };
  };
}
