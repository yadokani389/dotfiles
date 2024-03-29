# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../hosts/desktop ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      default = "saved";
      useOSProber = true;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
  };

  networking = {
    hostName = "nixos-kani";
    # wireless.enable = true;
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Tokyo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # inputMethod.fcitx5.waylandFrontend = true;
  };
  console.keyMap = "jp106";
  time.hardwareClockInLocalTime = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    xserver.videoDrivers = [ "nvidia" ];
  };

  services.blueman.enable = true;

  users.users.kani = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  environment = { systemPackages = with pkgs; [ neovim git zsh ]; };
  programs.zsh.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  system.stateVersion = "24.05";
}
