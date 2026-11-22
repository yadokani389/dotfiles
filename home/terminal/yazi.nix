{ inputs, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    package = inputs.yazi-nightly.packages.${pkgs.stdenv.hostPlatform.system}.yazi;

    initLua = ''
      require("git"):setup { order = 1500 }
    '';

    settings = {
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];

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
          on = "C";
          run = "plugin compress";
          desc = "Compress selected files";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "plugin vcs-files";
          desc = "Show Git file changes";
        }
        {
          on = "M";
          run = "plugin mount";
          desc = "Manage mounts";
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
      compress = inputs.yazi-plugins + "/compress.yazi";
      git = inputs.yazi-plugins + "/git.yazi";
      vcs-files = inputs.yazi-plugins + "/vcs-files.yazi";
      mount = inputs.yazi-plugins + "/mount.yazi";

      inherit (pkgs.yaziPlugins)
        jump-to-char
        smart-filter
        drag
        ;
    };
  };

  home.packages = with pkgs; [
    ripdrag
    _7zz
    udisks
    util-linux
  ];
}
