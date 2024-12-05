{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "refined";
        plugins = [ "git" ];
      };

      zsh-abbr = {
        enable = true;
        abbreviations = {
          ls = "eza";
          la = "eza -a";
          ll = "eza -l";
          lla = "eza -la";
          rm = "rm -rf";
          cp = "cp -r";
          "$" = "";
          lg = "lazygit";
          rusti = "evcxr";
        };
      };

      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
        export PATH=$HOME/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
        # Path to your oh-my-zsh installation.
        #export ZSH="$HOME/.oh-my-zsh"

        eval "$(zoxide init zsh)"

        # for refined theme
        any-nix-shell zsh --info-right | sed 's/precmd () {/& \nsetopt localoptions nopromptsubst\nvcs_info\nprint -P "\\n$(repo_information) %F{yellow}$(cmd_exec_time)%f"\nunset cmd_timestamp/' | source /dev/stdin
      '';
    };
  };
}
