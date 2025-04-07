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
          tauri-apps.tauri-vscode
          vue.volar
          github.copilot
          rooveterinaryinc.roo-cline
          saoudrizwan.claude-dev
          mkhl.direnv
          akamud.vscode-theme-onedark
        ])
        ++ (with pkgs.vscode-marketplace-release; [
          github.copilot-chat
          rust-lang.rust-analyzer
        ]);
    };
  };
}
