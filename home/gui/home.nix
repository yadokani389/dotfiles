{ pkgs, ... }:
{

  imports = [
    ./programs
    ./themes
  ];

  home.packages = with pkgs; [
    firefox
    obs-studio
    wlr-randr
    dunst
    pavucontrol
    xdg-utils
    mpc-cli
    tokyo-night-gtk
    playerctl
    pamixer
    brightnessctl
    python311Packages.pillow
    wl-clipboard
    tokyo-night-gtk
    nautilus
    zenity
    gnome-tweaks
    eog
    gimp
    wallpaper_random
    kooha
    xdragon
    rquickshare
    pavucontrol
    audiorelay
    wayvnc
  ];

  services = {
    kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
      indicator = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.fhs-fcitx5-with-addons;
      addons = with pkgs; [
        fcitx5-skk
        fcitx5-hazkey
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };

  systemd.user.services.wallpaper-changer = {
    Unit.Description = "change wallpaper random";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.wallpaper_random}/bin/wallpaper_random";
    };
  };

  systemd.user.timers.wallpaper-changer = {
    Unit = {
      Description = "change wallpaper random";
      Requires = [ "wallpaper-changer.service" ];
    };
    Timer = {
      Unit = "wallpaper-changer.service";
      OnBootSec = "10m";
      OnUnitActiveSec = "10m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
