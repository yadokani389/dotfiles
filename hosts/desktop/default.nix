{ pkgs, username, ... }: {
  imports = [ ./fonts ];

  hardware.pulseaudio.enable = false;
  services = {
    blueman.enable = true;

    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
        user = username;
      };
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
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
      hyprland.default = [ "gtk" "hyprland" ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
