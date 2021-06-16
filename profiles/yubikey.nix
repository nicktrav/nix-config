{ config, pkgs, ... }:

{
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    moreutils # For lsusb
  ];

  # Allow root users to access the smartcard.
  # See: https://github.com/NixOS/nixpkgs/issues/121121
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.debian.pcsc-lite.access_pcsc" ||
        action.id == "org.debian.pcsc-lite.access_card") &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  environment.variables = {
    "PKCS11_PATH" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };
}
