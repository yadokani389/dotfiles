{ inputs, pkgs, username, ... }: {
  imports = [ ../../home/home.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,1920x1200@60,0x0,1" ];
    input.kb_layout = "jp";
  };

  home = rec {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      __GL_VRR_ALLOWED = "1";
      CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
