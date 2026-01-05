{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.fhs-fcitx5-with-addons;
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-skk
        fcitx5-hazkey
      ];
    };
  };

  home.file.".config/hazkey/environment".text = ''
    export LIBLLAMA_PATH=${pkgs.hazkey-zenzai}/lib/hazkey/llama/libllama.so
    export HAZKEY_ZENZAI_MODEL=${pkgs.hazkey-zenzai}/share/hazkey/zenzai.gguf
  '';
}
