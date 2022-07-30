{ config, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  users.users.nickt.home = "/Users/nickt";

  # Home manager.

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nickt = { ... }: {
      home.stateVersion = "22.05";
      imports = [
        ../users/nickt/mbp.nix
      ];
    };
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
