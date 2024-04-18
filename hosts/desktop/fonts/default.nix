{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ jetbrains-mono ];
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      twemoji-color-font
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Noto" ]; })
    ];
  };
}
