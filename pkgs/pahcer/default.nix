{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "pahcer";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "terry-u16";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-yZaIZUuxlVJt/wvke+M6ATHXQLLE7siRx73IexY3njU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-yPeYrYZPGB2dxUQ7pvI+5WWXLEhX6DI2Qm2X2nqc3qQ=";

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
