final: prev:
let require = path: prev.callPackage (import path);
in {
  wallpaper_random = require ./wallpaper_random { };
  show-lyrics = require ./show-lyrics { };

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
}
