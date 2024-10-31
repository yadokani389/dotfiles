{ pkgs, ... }: {

  imports = [ ./programs ./themes ];

  home.packages = with pkgs; [
    firefox
    (flameshot.override { enableWlrSupport = true; })
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
  ];

  services = {
    kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
      indicator = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-skk ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
