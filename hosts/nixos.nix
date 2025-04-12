{ pkgs, username, ... }:
{
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.fcitx5.waylandFrontend = true;
  };

  security.rtkit.enable = true;

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
  };

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];
    hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  nix.settings = {
    auto-optimise-store = true;
    keep-outputs = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "${username}"
    ];
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
