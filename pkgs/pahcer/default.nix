{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "pahcer";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "terry-u16";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-LNQsmAvoAbWipdI9MZfeZfQ8826Dz0EzwjvHiICfFec=";
  };

  cargoHash = "sha256-kcDBrcEkx+ouxB9wQZsQ7bGplaYQ56c7LS186DRCXDs=";

  meta = {
    description = "A tool to run tests for AtCoder Heuristic Contest (AHC)";
    homepage = "https://github.com/terry-u16/pahcer";
    license = with lib.licenses; [
      asl20
      mit
    ];
    maintainers = [ ];
  };
}
