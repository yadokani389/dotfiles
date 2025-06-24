final: prev:
let
  require = path: prev.callPackage (import path);
in
{
  wallpaper_random = require ./wallpaper_random { };
  cargo-compete = require ./cargo-compete { };
  pahcer = require ./pahcer { };
  fcitx5-hazkey = require ./fcitx5-hazkey { };
  fhs-fcitx5-with-addons = require ./fhs-fcitx5-with-addons { };
  human-in-the-loop = require ./human-in-the-loop { };

  sptlrx = prev.sptlrx.overrideAttrs (old: rec {
    version = "1.2.3";
    src = prev.fetchFromGitHub {
      owner = "raitonoberu";
      repo = old.pname;
      rev = "v${version}";
      hash = "sha256-G8nYJZkXTtpgyBXrSO16hDVfsi3rmS92SddpmVgNN7Y=";
    };
    vendorHash = "sha256-NHXR1jwVNha9yNbI//l2OZ7Lny+9X0nB/Sg5m5gJEiQ=";
  });
}
