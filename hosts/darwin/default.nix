{ config, pkgs, ... }:

let 
  user = "nickt";
  combinedCA = /etc/nix/macos-keychain.crt;
  overlays = [ 
    (import ../../overlays/claude-code.nix)
    (import ../../overlays/cursor-agent.nix)
  ];

in

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    ../../modules/shared/cachix
  ];

  nixpkgs.overlays = overlays;

  # Special CA needed on my work laptop.
  # TODO(nick): Move this down.
  #environment.etc."ssl/certs/combined-nix-ca.pem".text =
  #  builtins.readFile ./certs/cacert-2025-08-12.pem + "\n" +
  #  builtins.readFile ./certs/netskope.pem;

  # Let nix-darwin "own" /etc/nix/nix.conf by sourcing your current file.
  #environment.etc."nix/nix.conf".source = "/etc/nix/nix.conf";
  # optional but nice: set permissions explicitly
  #environment.etc."nix/nix.conf".mode = "0644";

  #environment.etc."ssl/certs/combined-nix-ca.pem".source = combinedCA;

  system.primaryUser = "${user}";

  # Setup user, packages, programs
  nix = {
    # Disabled to make this work with Determinate's daemon.
    enable = false;

    package = pkgs.nix;
    #settings.ssl-cert-file = /Users/nickt/.nix-certs/netskope.crt;
    #settings.ssl-cert-file = "/etc/ssl/certs/combined-nix-ca.pem";
    #settings.ssl-cert-file = ./certs/combined-nix-ca.pem;
    #settings.ssl-cert-file = /etc/nix/macos-keychain.crt;

    #gc = {
    #  automatic = true;
    #  interval = { Weekday = 0; Hour = 2; Minute = 0; };
    #  options = "--delete-older-than 30d";
    #};

    # NOTE: The following was translated via ChatGPT from the Determinate
    # Systems installer generated /etc/nix/nix.conf file. Having this here
    # makes it play nicely with the nix-darwin version.
    settings = {
      trusted-users = [ "@admin" "${user}" ];

      # ---- from max-jobs = auto
      max-jobs = "auto";

      # ---- from extra-experimental-features = nix-command flakes
      experimental-features = [ "nix-command" "flakes" ];

      # ---- from netrc-file
      netrc-file = "/nix/var/determinate/netrc";

      # ---- from bash-prompt-prefix
      bash-prompt-prefix = "(nix:$name)\\040";

      # ---- substituters / trust (normalize "extra-*" -> standard settings)
      # Your original only *added* install.determinate.systems as a substituter,
      # and trusted flakehub + install.determinate; we include cache.nixos.org too.
      substituters = [
        "https://cache.nixos.org"
        "https://install.determinate.systems"
        "https://cache.flakehub.com"
      ];

      trusted-substituters = [
        "https://install.determinate.systems"
        "https://cache.flakehub.com"
      ];

      # Include cache.nixos key (needed when you set substituters explicitly),
      # plus your flakehub keys as provided.
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16GkB53Wh8Z3ZABs="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
      ];

      # ---- from extra-nix-path
      # (Nix still honors nix-path; fine to point a flake here.)
      nix-path = [ "nixpkgs=flake:https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz" ];

      # ---- from ssl-cert-file
      ssl-cert-file = /etc/nix/macos-keychain.crt;
    };

    # Optional: keep the old `!include nix.custom.conf` behavior.
    # If the file exists, append its contents verbatim.
    extraOptions = pkgs.lib.mkIf (builtins.pathExists /etc/nix/nix.custom.conf)
      (builtins.readFile /etc/nix/nix.custom.conf);
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  #environment.systemPackages = with pkgs; [
  #  emacs-unstable
  #] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  #launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  #launchd.user.agents.emacs.serviceConfig = {
  #  KeepAlive = true;
  #  ProgramArguments = [
  #    "/bin/sh"
  #    "-c"
  #    "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
  #  ];
  #  StandardErrorPath = "/tmp/emacs.err.log";
  #  StandardOutPath = "/tmp/emacs.out.log";
  #};

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "right";
        tilesize = 40;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
