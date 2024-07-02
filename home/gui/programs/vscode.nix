{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      mgt19937.typst-preview
      nvarner.typst-lsp
    ];
  };
}
