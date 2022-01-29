{ config, pkgs, ... }:

{

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Install home-manager.
  # NOTE: this relies on the channel being added.
  # TODO(nickt): Add channel command.

  imports = [
    <home-manager/nix-darwin>
  ];

  home-manager = {
    useUserPackages = true;
  };

  home-manager.users.nickt = (import ./packages.nix);

  # Fonts.

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      inconsolata
      powerline-fonts
    ];
  };

  # System packages.

  environment.systemPackages = with pkgs; [
    bash
    reattach-to-user-namespace
  ];

  # TODO(nickt): Move the yubikey specific things into their own package.
  environment.variables = {
    "PKCS11_PATH" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };

  # Used for backwards compatibility, please read the changelog before
  # changing.
  system.stateVersion = 4;
}
