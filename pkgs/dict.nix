{ pkgs, ... }: {
  home.packages = with pkgs; [
    dict
  ];

  # Create the dict server configuration.
  # See: https://nixos.wiki/wiki/Dict
  home.file.".dictrc".text = ''
    server dict.org
  '';
}
