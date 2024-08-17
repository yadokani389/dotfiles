{ username, ... }: {
  imports = [ ../../home/gui/home.nix ../../home/cui/home.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,1920x1200@60,0x0,1" ];
    input.kb_layout = "jp";
  };

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      # __GL_VRR_ALLOWED = "1";
      # CLUTTER_BACKEND = "wayland";
      # WLR_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";

      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
