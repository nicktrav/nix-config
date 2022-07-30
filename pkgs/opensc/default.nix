{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    opensc
  ];

  home.sessionVariables = {
    "PKCS11_PATH" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };
}
