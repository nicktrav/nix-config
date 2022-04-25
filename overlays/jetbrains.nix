{ config, ... }: {
  nixpkgs.config.jetbrains.vmopts = ''
    -Xms8g
    -Xmx8g
  '';
}
