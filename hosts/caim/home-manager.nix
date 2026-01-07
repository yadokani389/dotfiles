username:
{
  inputs,
  pkgs,
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
    input.kb_layout = "jp";
  };

  programs.niri.settings = {
    input.keyboard.xkb.layout = "jp";
    binds = {
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };
    };
  };

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

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
