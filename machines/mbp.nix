{ pkgs, config, ... }:

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

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      _apps=/nix/var/nix/profiles/per-user/nickt/home-manager/home-path/Applications/*;
      for app in $_apps; do
        cp -fHRL "$app" ~/Applications/Nix\ Apps/
      done
    ''
  );

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
