{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ jetbrains-mono ];
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-extra
      twemoji-color-font
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Noto" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
        monospace = [ "FiraCode Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
