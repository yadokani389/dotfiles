{ config, lib, pkgs, ... }: {
  imports = [ ./fonts ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = with pkgs; [ gnome.gnome-session ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };
}
