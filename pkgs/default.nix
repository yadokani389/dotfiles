final: prev:
let
  require = path: prev.callPackage (import path);
in
{
  wallpaper_random = require ./wallpaper_random { };
  cargo-compete = require ./cargo-compete { };
  pahcer = require ./pahcer { };

  swww = prev.swww.overrideAttrs (_: rec {
    version = "2024-12-05";

    src = prev.fetchFromGitHub {
      owner = "LGFae";
      repo = "swww";
      rev = "004dfd8b91c1d271b499bb99eb7c6746b1c2e069";
      hash = "sha256-fgLWCUouo4RhTfLB5/aPT8mpU/GVgbUiubwrHYg0pTI=";
    };
    cargoDeps = prev.rustPlatform.importCargoLock {
      lockFile = "${src}/Cargo.lock";
      allowBuiltinFetchGit = true;
    };
  });
}
