{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Yaru-magenta-dark";
      package = pkgs.yaru-theme;
    };

    theme = {
      name = "Tokyonight-Dark-B-LB";
      package = pkgs.tokyonight-gtk-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
    };
  };
}
