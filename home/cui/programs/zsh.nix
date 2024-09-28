{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "refined";
        plugins = [ "git" ];
      };

      shellAliases = {
        ls = "eza";
        la = "eza -a";
        ll = "eza -l";
        lla = "eza -la";
        rm = "rm -rf";
        cp = "cp -r";
        "$" = "";
      };

      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }];

      initExtra = ''
        export PATH=$HOME/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
        # Path to your oh-my-zsh installation.
        #export ZSH="$HOME/.oh-my-zsh"

        ZSH_THEME="refined"
        REFINED_CHAR_SYMBOL="⚡"

        eval "$(zoxide init zsh)"
      '';
    };
  };
}
