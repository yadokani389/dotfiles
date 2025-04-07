{ pkgs, ... }:
{
  fonts = {
    packages =
      (with pkgs; [
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        noto-fonts-monochrome-emoji
        twemoji-color-font
        fira-code-symbols
      ])
      ++ (with pkgs.nerd-fonts; [
        fira-code
        jetbrains-mono
        noto
      ]);
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Emoji"
        ];
        monospace = [
          "FiraCode Nerd Font"
          "JetBrainsMono Nerd Font Mono"
          "Noto Emoji"
        ];
        emoji = [ "Noto Emoji" ];
      };
    };
  };
}
