{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./fonts.nix
    ./speech-cpp.nix
    inputs.niri-flake.nixosModules.niri
  ];

  security.pam.services.hyprlock = { };

  users.groups.uinput.members = lib.attrNames (
    lib.filterAttrs (_: user: user.systemd.user.services ? hyprwhspr) config.home-manager.users
  );

  services = {
    blueman.enable = true;

    displayManager.defaultSession = "niri";
    xserver.enable = true;

    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    uinput.enable = true;
  };

  programs = {
    dconf.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    ydotool = {
      enable = true;
      group = "uinput";
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
    gnome-weather
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gnome" ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };
}
