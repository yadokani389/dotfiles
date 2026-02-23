{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      opener.pdf = [
        {
          run = "tdf %s";
          block = true;
          desc = "PDF viewer";
          for = "unix";
        }
      ];

      open.append_rules = [
        {
          mime = "application/pdf";
          use = "pdf";
        }
      ];
    };
  };
}
