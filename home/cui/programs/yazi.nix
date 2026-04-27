{ inputs, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi;
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

      open.prepend_rules = [
        {
          mime = "application/pdf";
          use = "pdf";
        }
      ];
    };
  };
}
