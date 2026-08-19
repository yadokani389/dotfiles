username: hashedPassword: hostname:
{ pkgs, ... }:
{
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.enable = false;
  };

  security.rtkit.enable = true;

  programs = {
    zsh.enable = true;
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
      "input"
    ];
    inherit hashedPassword;
  };

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    firewall.enable = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "${username}"
    ];
  };

}
