{ config, lib, pkgs, ... }: {
  imports = [ ./fonts ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        user = "kani";
        command = "$SHELL -l";
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = with pkgs; [ gnome.gnome-session ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };
}
