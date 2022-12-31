{ config, pkgs, ... }:

let
  keyboardLayout = pkgs.writeText "xkb-layout" ''
    ! Re-map escape to caps lock
    remove lock = Caps_Lock
    keycode 66 = Escape NoSymbol Escape

    ! Exchange left alt and left win
    !remove mod1 = Alt_L
    !remove mod4 = Super_L
    !add mod1 = Super_L
    !add mod4 = Alt_L
  '';

in
{
  imports = [
    ./shared.nix

    # TOOD: Ideally this would be imported via home-manager, but I can't work
    # out how to get that working.
    ../overlays/jetbrains.nix
  ];

  # Overlays.
  nixpkgs.overlays = [
    (import ../overlays/chrome.nix)
  ];

  # Use a more recent Linux kernel.
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;

  # Enable host-specific interfaces.
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp45s0u2.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Allow user logins after basic system initialization. This avoids having to
  # wait for all network interfaces to obtain a DHCP lease before a user can
  # log in.
  # See: https://github.com/NixOS/nixpkgs/issues/60900
  systemd.services.systemd-user-sessions.enable = false;

  # Tailscale networking.
  services.tailscale.enable = true;

  # Firewall.
  networking.firewall = {
    enable = true;
    interfaces = {
      "enp45s0u2" = {
        allowedTCPPorts = [ 22 ];
      };
      "tailscale0" = {
        allowedTCPPorts = [ 22 ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };
      "wlp0s20f3" = {
        allowedTCPPorts = [ 22 ];
      };
    };
    checkReversePath = "loose";
  };

  # Remain open with the lid closed.
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Remap keys; increase trackpad speed.
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${keyboardLayout}
    ${pkgs.xorg.xinput}/bin/xinput --set-prop 13 338 0.5
  '';

  # Enable brightness keys.
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

  # Enable virtualization.
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # System packages.
  environment.systemPackages = with pkgs; [
    tailscale
    virt-manager
    xorg.xmodmap
  ];

  # Home manager.
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nickt = { ... }: {
      home.stateVersion = "22.05";
      imports = [
        ../users/nickt/x1.nix
      ];
    };
  };

  users.users.nickt = {
    isNormalUser = true;
    home = "/home/nickt";
    extraGroups = [ "wheel" "docker" "libvirtd" ];
    shell = pkgs.bash;
    hashedPassword = "$6$A4Qj3zATN$p1dfabtmVJa9aE02Px1tsufmeS1TP3AE6LU6V/36mqvHVW1gtvQl0Li8D8tdVW9G0rP1P7M4CN7hdG7CgfsFY1";
    openssh.authorizedKeys.keyFiles = [
      ../users/nickt/authorized_keys
    ];
  };
}
