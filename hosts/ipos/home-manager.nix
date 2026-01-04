{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../home/gui/home.nix
    ../../home/cui/home.nix
    ../../home/cui/minimal.nix
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,1920x1200@60,0x0,1" ];
    input.kb_layout = "jp";
  };

  programs.niri.settings = {
    input.keyboard.xkb.layout = "jp";
    outputs."eDP-1".scale = 0.9;
    binds = {
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };
    };
  };

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [
      nvtopPackages.intel
      btop
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      TERMINAL = "kitty";
    };
  };
}
