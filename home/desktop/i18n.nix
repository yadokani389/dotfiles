{ inputs, pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons =
        (with pkgs; [
          fcitx5-skk
          karukan-im-gpu
        ])
        ++ [
          inputs.skkzenz.packages."${pkgs.stdenv.hostPlatform.system}".skkzenz-fcitx5-vulkan
        ];
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "jp";
          DefaultIM = "skk-zenz";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-jp";
          Layout = null;
        };
        "Groups/0/Items/1" = {
          Name = "skk-zenz";
          Layout = null;
        };
      };
    };
  };

  xdg.configFile.fcitx5 = {
    recursive = true;
    force = true;
  };

  home.file.".local/share/karukan-im/dict.bin".source = "${
    pkgs.fetchzip {
      url = "https://github.com/togatoga/karukan/releases/download/v0.1.0/dict.tgz";
      hash = "sha256-gWUZH3FQfuksslb/AqUvBU0OVFe9DMg0+8SpGHlASqA=";
      stripRoot = false;
    }
  }/dict.bin";

  home.file.".config/skk-zenz/dictionary_list".text =
    "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
}
