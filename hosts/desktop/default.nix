{ pkgs, ... }:
{
  imports = [ ./fonts ];

  services = {
    blueman.enable = true;

    displayManager.defaultSession = "hyprland";
    xserver.enable = true;

    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
