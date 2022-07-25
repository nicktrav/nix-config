{ config, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nickt = import ../users/nickt/home-manager-mbp.nix;
  };


  # Fonts.

  fonts = {
    fontDir.enable = true;
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

  # Used for backwards compatibility, please read the changelog before
  # changing.
  system.stateVersion = 4;
}
