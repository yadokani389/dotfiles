{ pkgs, username, ... }: {
  imports = [ ./fonts ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        user = username;
        command = "$SHELL -l";
      };
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
