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
      extraEntries = ''
                menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-094E-3E9F' {
        	  insmod part_gpt
        	  insmod fat
        	  search --no-floppy --fs-uuid --set=root 094E-3E9F
        	  chainloader /efi/Microsoft/Boot/bootmgfw.efi
                }
                menuentry 'Arch Linux (on /dev/nvme0n1p2)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-6a7a7f3f-cd9a-4090-91fd-f6e71b04b25f' {
        	  insmod part_gpt
        	  insmod fat
        	  search --no-floppy --fs-uuid --set=root 094E-3E9F
        	  linux /vmlinuz-linux root=/dev/nvme0n1p2
        	  initrd /initramfs-linux.img
                }
                submenu 'Advanced options for Arch Linux (on /dev/nvme0n1p2)' $menuentry_id_option 'osprober-gnulinux-advanced-6a7a7f3f-cd9a-4090-91fd-f6e71b04b25f' {
                  menuentry 'Arch Linux (on /dev/nvme0n1p2)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/vmlinuz-linux--6a7a7f3f-cd9a-4090-91fd-f6e71b04b25f' {
        	    insmod part_gpt
        	    insmod fat
        	    search --no-floppy --fs-uuid --set=root 094E-3E9F
                    linux /vmlinuz-linux root=/dev/nvme0n1p2
        	    initrd /initramfs-linux.img
        	  }
                }
      '';
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
