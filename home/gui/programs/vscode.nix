{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.insertFinalNewline" = true;
        "workbench.colorTheme" = "Atom One Dark";
      };
      extensions =
        (with pkgs.vscode-marketplace; [
          ms-vsliveshare.vsliveshare
          rust-lang.rust-analyzer
          tauri-apps.tauri-vscode
          vue.volar
          github.copilot
          coolcline.coolcline
          mkhl.direnv
          akamud.vscode-theme-onedark
        ])
        ++ [
          pkgs.vscode-marketplace-release.github.copilot-chat
        ];
    };
  };
}
