{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ twemoji-color-font ];
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk
      noto-fonts-emoji
      twemoji-color-font
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Noto" ]; })
    ];
  };
}
