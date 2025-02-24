{ pkgs, inputs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.insertFinalNewline" = true;
      };
      extensions =
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
          ms-vsliveshare.vsliveshare
          rust-lang.rust-analyzer
          tauri-apps.tauri-vscode
          vue.volar
          github.copilot
          coolcline.coolcline
          mkhl.direnv
        ])
        ++ [
          inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release.github.copilot-chat
        ];
    };
  };
}
