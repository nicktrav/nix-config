let
  nixpkgsRev = "20.03";
  nixpkgs = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${nixpkgsRev}.tar.gz";
    sha256 ="0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
  };
  pkgs = import nixpkgs { };
in
{ config, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  # Allow unfree packages
  nixpkgs.config = import ./config.nix;

  imports = [
    ./dotfiles/dotfiles.nix
    ./libraries/boringssl/boringssl.nix
    ./programs/alacritty/alacritty.nix
    ./programs/certigo/certigo.nix
    ./programs/cue/cue.nix
    ./programs/curl/curl.nix
    ./programs/go/go.nix
    ./programs/i3/i3.nix
    ./programs/polybar/polybar.nix
    ./programs/vim/vim.nix
    ./programs/yubico-piv-tool/yubico-piv-tool.nix
    #./programs/yubikey-agent/yubikey-agent.nix

    ./multi-glibc-locale-paths.nix
  ];

  #programs.alacritty.enable = true;
  programs.boringssl.enable = true;
  programs.certigo.enable = true;
  programs.cue.enable = true;
  programs.curl.enable = true;
  programs.go.enable = true;
  programs.yubico-piv-tool.enable = true;
  #programs.yubikey-agent.enable = true;
  programs.chromium.enable = true;

  fonts.fontconfig = {
    enable = true;
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {

      bars = [];
      window.border = 0;

      keybindings =
        let modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Return"  = "exec alacritty";
          "${modifier}+d"       = "exec rofi -modi drun -show drun -theme gruvbox-dark-soft";
          "${modifier}+Shift+d" = "exec rofi -show window";

          # Vim keybindings
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Brightness controls
          "XF86MonBrightnessUp" = "exec xbacklight +10";
          "XF86MonBrightnessDown" = "exec xbacklight -10";

          # Volume controls
          "XF86AudioMute" = "exec alsa set Master toggle";
          "XF86AudioLowerVolume" = "exec alsa set Master 4%-";
          "XF86AudioRaiseVolume" = "exec alsa set Master 4%+";

          # Lock screen
          #"${modifier}+Shift+x" = "exec betterlockscreen -l dim";
        };

      startup = [
        {
          command = "setxkbmap -option caps:escape";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
      ];

      window.commands = [
        {
          criteria = {
            "class" = "^.*";
          };
          command = "border pixel 0";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    awscli
    cacert
    cargo
    coreutils
    dep2nix
    nerdfonts
    powerline-fonts
    fzf
    git
    glibcLocales
    gnupg
    gucharmap
    google-cloud-sdk
    htop
    inconsolata
    maven
    opensc
    openssh
    packer
    pcsctools
    protobuf
    nghttp2
    nix-prefetch-git
    ripgrep
    rustc
    shellcheck
    spotify
    ssh-agents
    unzip
    vim
    wireguard
    wget
    xorg.xbacklight
    yubikey-manager
  ];
}
