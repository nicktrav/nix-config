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
    (import ../overlays/nix-direnv.nix)
  ];

  # Use a more recent Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_5_16;

  # Enable host-specific interfaces.
  networking.interfaces.enp0s31f6.useDHCP = false;
  networking.interfaces.enp45s0u2.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = false;
  networking.networkmanager.enable = true;

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
}
