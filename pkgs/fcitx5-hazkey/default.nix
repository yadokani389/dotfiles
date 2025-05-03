{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  fcitx5,
  vulkan-loader,
}:

stdenv.mkDerivation {
  pname = "fcitx5-hazkey";
  version = "0.0.9";

  src = fetchurl {
    url = "https://github.com/7ka-Hiira/fcitx5-hazkey/releases/download/0.0.9/fcitx5-hazkey-0.0.9-x86_64.tar.gz";
    hash = "sha256-WPJDxp5iHEVjsiMt9NhvxVQShYYRPa51gDwA0dG2H3I=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    fcitx5
    vulkan-loader
  ];

  installPhase = ''
    install -Dm755 lib/x86_64-linux-gnu/libhazkey.so $out/lib/libhazkey.so
    install -Dm755 lib/x86_64-linux-gnu/fcitx5/fcitx5-hazkey.so $out/lib/fcitx5/fcitx5-hazkey.so
    mkdir -p $out
    cp -r share $out/
  '';

  meta = with lib; {
    description = "Japanese input method for fcitx5, powered by azooKey engine";
    homepage = "https://github.com/7ka-Hiira/fcitx5-hazkey";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
