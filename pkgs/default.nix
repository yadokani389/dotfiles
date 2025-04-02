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

  minecraftServers.vanilla-25w14craftmine = prev.minecraftServers.vanilla-1-20.overrideAttrs (_: {
    version = "25w14craftmine";

    src = prev.fetchurl {
      url = "https://piston-data.mojang.com/v1/objects/4527a9019e37e001770787e4523b505f79cac4c5/server.jar";
      hash = "sha256-ksF5A9v45zjb2HaKcYeXW2mwXSnJ5Hn42g6SIp+5Hsc=";
    };
  });
}
