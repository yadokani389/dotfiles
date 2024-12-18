{ username, ... }: {
  imports = [
    ../../home/gui/home.nix
    ../../home/cui/home.nix
    ../../home/cui/minimal.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [ "HDMI-A-1,preferred,auto,1.25" "DP-1,preferred,auto-right,1,transform,3" ];
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
      # GBM_BACKEND = "nvidia-drm";
      # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
      # __GL_VRR_ALLOWED = "1";
      # WLR_NO_HARDWARE_CURSORS = "1";
      # WLR_RENDERER_ALLOW_SOFTWARE = "1";
      # CLUTTER_BACKEND = "wayland";
      # WLR_RENDERER = "vulkan";
      # NIXOS_OZONE_WL = "1";

      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      # QT_QPA_PLATFORM = "wayland";
      # SDL_VIDEODRIVER = "wayland";
      # XDG_SESSION_TYPE = "wayland";
    };
  };
}
