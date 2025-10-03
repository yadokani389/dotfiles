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
  audiorelay = require ./audiorelay { };
}
