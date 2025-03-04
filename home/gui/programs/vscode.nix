{ pkgs, inputs, ... }:
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
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
          ms-vsliveshare.vsliveshare
          rust-lang.rust-analyzer
          tauri-apps.tauri-vscode
          vue.volar
          (github.copilot.override { meta.license = [ ]; })
          coolcline.coolcline
          mkhl.direnv
          akamud.vscode-theme-onedark
        ])
        ++ [
          (inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release.github.copilot-chat.override { meta.license = [ ]; })
        ];
    };
  };
}
