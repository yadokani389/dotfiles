{ pkgs, username, ... }: {
  time.timeZone = "Asia/Tokyo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.fcitx5.waylandFrontend = true;
  };
  time.hardwareClockInLocalTime = true;

  security.rtkit.enable = true;
  programs = {
    zsh.enable = true;
    git.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 30d";
      };
    };
  };

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    hashedPassword =
      "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  nix = {
    package = pkgs.lix;

    settings = {
      auto-optimise-store = true;
      keep-outputs = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" ];

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://yadokani389.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "yadokani389.cachix.org-1:xHw9jijQFNDKlNprHbQpXX6cVOUO4m/n2lBfx6Bq4jg="
      ];
    };
  };

  nixpkgs.flake = {
    setNixPath = false;
    setFlakeRegistry = false;
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    baobab # disk usage analyzer
    cheese # photo booth
    epiphany # web browser
    gedit # text editor
    orca # screen reader
    simple-scan # document scanner
    yelp # help viewer
    file-roller # archive manager
    geary # email client
    seahorse # password manager

    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-weather
  ];

  system.stateVersion = "24.05";
}
