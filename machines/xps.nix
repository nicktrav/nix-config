{ pkgs, ... }: {
  imports = [
    ../users/nickt/xps.nix
  ];

  # See https://github.com/nix-community/home-manager/issues/2942.
  nixpkgs.config.allowUnfreePredicate = (_: true);

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
