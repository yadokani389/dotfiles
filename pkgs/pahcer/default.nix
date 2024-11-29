{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "pahcer";
  version = "0.1.1";
  src = fetchFromGitHub {
    owner = "terry-u16";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-f4R+I00uRl2fBOnHejBzjkM596rSJH7s8+/vySH3WnY=";
  };
  cargoHash = "sha256-WuOHNadz5/xeBcVNdQwZ1XbPbEKh6BFUG0LJp3wuIqw=";
}
