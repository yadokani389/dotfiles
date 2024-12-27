final: prev:
let require = path: prev.callPackage (import path);
in {
  wallpaper_random = require ./wallpaper_random { };
  cargo-compete = require ./cargo-compete { };
  pahcer = require ./pahcer { };

  sptlrx = prev.sptlrx.overrideAttrs (_: rec {
    version = "1.2.2";
    src = prev.fetchFromGitHub {
      owner = "raitonoberu";
      repo = "sptlrx";
      rev = "v${version}";
      hash = "sha256-b8ALhEjolH0RH+I9HVQeOagPBi2isLNUxqKdj5u2O9s=";
    };
    vendorHash = "sha256-pExSQcYjqliZZg/91t52yk6UJ4QCbpToMpONIFUNkwc=";
    doCheck = false;
  });

  evcxr = prev.evcxr.overrideAttrs (_: {
    postInstall = let
      wrap = exe: ''
        wrapProgram $out/bin/${exe} \
          --prefix PATH : ${
            prev.lib.makeBinPath (with prev; [ cargo rustc gcc ])
          } \
          --set-default RUST_SRC_PATH "$RUST_SRC_PATH"
      '';
    in ''
      ${wrap "evcxr"}
      ${wrap "evcxr_jupyter"}
      rm $out/bin/testing_runtime
    '';
  });

  swww = prev.swww.overrideAttrs (drv: rec {
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
