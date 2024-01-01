{ config, pkgs, ... }: {
  nixpkgs.config.jetbrains.vmopts = ''
    -Xms8g
    -Xmx8g
  '';
  home.packages = with pkgs; [
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
  ];
}
