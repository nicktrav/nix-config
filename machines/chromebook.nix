{ pkgs, ... }: {
  imports = [
    ../users/nickt/chromebook.nix
  ];

  # TODO(nickt): Figure out why this is needed.
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  # Home manager.
  programs.home-manager.enable = true;
  home = {
    username = "nickt";
    homeDirectory = "/home/nickt";
    stateVersion = "22.05";
  };
  news.display = "silent";
}
