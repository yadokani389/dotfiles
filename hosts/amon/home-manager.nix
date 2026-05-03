username:
{
  pkgs,
  ...
}:
{
  imports = [
    ../../home/gui/home.nix
    ../../home/cui/full.nix
  ];

  programs = {
    home-manager.enable = true;

    niri.settings = {
      input.keyboard.xkb.layout = "jp";
      outputs."HDMI-A-1".transform.rotation = 90;
      binds = {
        "Mod+U".action.focus-monitor-previous = { };
        "Mod+I".action.focus-monitor-next = { };
      };
    };

    git.settings.user = {
      name = "yadokani389";
      email = "yadokani389@gmail.com";
    };
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";

    packages = with pkgs; [
      nvtopPackages.nvidia
      btop-cuda
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen-beta";
      TERMINAL = "kitty";
    };
  };
}
