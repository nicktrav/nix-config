{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
  ];
}