{
  lib,
  stdenv,
  fetchFromGitHub,
  nodejs,
  pnpm_9,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "difit";
  version = "2.0.11";

  src = fetchFromGitHub {
    owner = "yoshiko-pg";
    repo = finalAttrs.pname;
    tag = "v${finalAttrs.version}";
    hash = "sha256-lKwoQVuMIjsJlRayYF46Khf6mwxjrlspT6H1bFvh4fU=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm_9.configHook
  ];

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-vq9jDuaQ7H6fAEOJ8cz0+zq1ySGn5PbovSlJL5hOU9k=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm build

    runHook postBuild
  '';

  # remove unnecessary and non-deterministic files
  preInstall = ''
    pnpm --ignore-scripts --prod prune
    find -type f \( -name "*.ts" -o -name "*.map" \) -exec rm -rf {} +
    # https://github.com/pnpm/pnpm/issues/3645
    find node_modules -xtype l -delete

    rm node_modules/.modules.yaml
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,lib/difit}
    mv {node_modules,dist,package.json} $out/lib/difit
    ln -s $out/lib/difit/dist/cli/index.js $out/bin/difit
    chmod +x $out/bin/difit

    runHook postInstall
  '';

  meta = {
    description = "A lightweight command-line tool that spins up a local web server to display Git commit diffs in a GitHub-like Files changed view";
    homepage = "https://github.com/yoshiko-pg/difit";
    license = lib.licenses.mit;
  };
})
