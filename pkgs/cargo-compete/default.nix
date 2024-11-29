{ rustPlatform, fetchFromGitHub, pkg-config, openssl }:
rustPlatform.buildRustPackage rec {
  pname = "cargo-compete";
  version = "0.10.7";

  src = fetchFromGitHub {
    owner = "qryxip";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-qlRVHSUVOqdTx4H3pE19Fy634742veTisHm6IqfKBUQ=";
  };

  cargoHash = "sha256-gj+UiYVViYEYupboYqVBypkt8fpt7WBv04+Tjy/qeQc=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;
}
