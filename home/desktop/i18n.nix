{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-skk
      ];
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "jp";
          DefaultIM = "skk";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-jp";
          Layout = null;
        };
        "Groups/0/Items/1" = {
          Name = "skk";
          Layout = null;
        };
      };
    };
  };

  xdg.configFile.fcitx5 = {
    recursive = true;
    force = true;
  };
}
