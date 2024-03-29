{ hyprland, nixvim, pkgs, ... }: {

  imports = [
    hyprland.homeManagerModules.default
    #./environment
    ./programs
    ./scripts
    ./themes
  ];

  home = rec {
    username = "kani";
    homeDirectory = "/home/kani";
    stateVersion = "24.05";
  };

  home.packages = (with pkgs; [

    #User Apps
    firefox
    kitty
    spotify
    discord
    flameshot
    obs-studio
    vscode

    #utils
    ranger
    wlr-randr
    git
    gnumake
    curl
    dunst
    pavucontrol
    sqlite
    nix-direnv
    wlogout
    xdg-utils
    gh
    bat
    lazydocker
    appimage-run
    unzip

    #misc 
    cava
    rofi
    nitch
    wget
    grim
    grimblast
    slurp
    wl-clipboard
    mpc-cli
    tty-clock
    eza
    btop
    tokyo-night-gtk
    fzf
    zoxide
    playerctl
    pamixer
    sptlrx
    neofetch
    ripgrep

    nixvim.packages."x86_64-linux".default

    #development
    cmake
    ninja
    pkgconf
    go
    gopls
    gcc
  ]) ++ (with pkgs.gnome; [ nautilus zenity gnome-tweaks eog ]);

  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
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

  programs.home-manager.enable = true;
}
