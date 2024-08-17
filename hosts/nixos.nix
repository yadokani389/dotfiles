{ pkgs, username, ... }: {
  time.timeZone = "Asia/Tokyo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.fcitx5.waylandFrontend = true;
  };
  time.hardwareClockInLocalTime = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  services.blueman.enable = true;

  programs = {
    zsh.enable = true;
    git.enable = true;
    regreet.enable = true;
    dconf.enable = true;
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
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
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

  system.stateVersion = "24.05";
}
