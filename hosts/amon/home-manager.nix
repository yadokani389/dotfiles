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
    monitor = [
      "HDMI-A-1, preferred, 0x0, 1, transform, 1"
      "DP-2, preferred, 1080x0, 1.25"
      "DP-1, preferred, 4152x0, 1"
    ];
    workspace = [
      "1, monitor:HDMI-A-1"
      "2, monitor:DP-2"
      "3, monitor:DP-1"
    ];
    input.kb_layout = "jp";
  };

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [
      ollama-cuda
      nvtopPackages.nvidia
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      TERMINAL = "kitty";
    };
  };
}
