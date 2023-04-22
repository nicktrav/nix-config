{ config, pkgs, lib, currentSystem, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree software.
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so this
  # generated config replicates the default behaviour.
  networking.useDHCP = false;

  # Enable the Network Manager CLI.
  networking.networkmanager.enable = true;

  # Don't require password for sudo.
  security.sudo.wheelNeedsPassword = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  # Manage fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      inconsolata
      inconsolata-nerdfont
      nerdfonts
      powerline-fonts
    ];
  };

  # System packages.
  environment.systemPackages = with pkgs; [
    killall
    moreutils
    gcc
  ];

  # Some programs need SUID wrappers, can be configured further or are started
  # in user sessions.
  programs.mtr.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  # Smartcard support.
  services.pcscd.enable = true;

  # Allow root users to access the smartcard.
  # See: https://github.com/NixOS/nixpkgs/issues/121121
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.debian.pcsc-lite.access_pcsc" ||
        action.id == "org.debian.pcsc-lite.access_card") &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
