{ inputs, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    package = inputs.yazi-nightly.packages.${pkgs.stdenv.hostPlatform.system}.yazi;

    settings = {
      opener.pdf = [
        {
          run = "tdf %s";
          block = true;
          desc = "PDF viewer";
          for = "unix";
        }
      ];

      open.prepend_rules = [
        {
          mime = "application/pdf";
          use = "pdf";
        }
      ];
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "f";
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = "F";
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        {
          on = [ "<C-d>" ];
          run = "plugin drag";
          desc = "Drag Files";
        }
        {
          on = "Z";
          run = "plugin sftp-zoxide";
          desc = "Jump to a directory via zoxide";
        }
      ];
    };

    plugins = {
      sftp-zoxide = ./yazi-plugins/sftp-zoxide.yazi;

      inherit (pkgs.yaziPlugins)
        jump-to-char
        smart-filter
        drag
        ;
    };
  };

  home.packages = with pkgs; [
    ripdrag
  ];
}
