{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vsliveshare.vsliveshare
      rust-lang.rust-analyzer
      tauri-apps.tauri-vscode
      vue.volar
    ];
  };
}
