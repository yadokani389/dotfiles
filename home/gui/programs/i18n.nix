{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.callPackage (
        {
          buildFHSEnv,
          addons ? [ ],
        }:
        buildFHSEnv {
          name = "fcitx5";
          targetPkgs = pkgs: [
            (pkgs.qt6Packages.fcitx5-with-addons.override { inherit addons; })
          ];
          runScript = "fcitx5";
        }
      ) { };
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-skk
        fcitx5-hazkey
        karukan-im
      ];
    };
  };

  home.file.".config/hazkey/environment".text = ''
    export LIBLLAMA_PATH=${pkgs.hazkey-zenzai}/lib/hazkey/llama/libllama.so
    export HAZKEY_ZENZAI_MODEL=${pkgs.hazkey-zenzai}/share/hazkey/zenzai.gguf
  '';
}
