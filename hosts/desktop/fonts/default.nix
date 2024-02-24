{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
      fira-code
      fira-code-symbols
    ];
  };
}
