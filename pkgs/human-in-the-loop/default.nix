{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "human-in-the-loop";
  version = "unstable-2025-06-23";

  src = fetchFromGitHub {
    owner = "KOBA789";
    repo = "human-in-the-loop";
    rev = "2dbe61783c2697ec25ce8bf8a39017f0a994e9b4";
    hash = "sha256-3n3HdcKiGZLKvM4D0dKnvCq/g1HOm1C+Xc3kL4O4+aw=";
  };

  cargoHash = "sha256-YeDOQKM3DjkWMR4h6OdqYje8DlFjjnWLg9PfwAELrBU=";

  meta = {
    description = "An MCP (Model Context Protocol) server that allows AI assistants to ask questions to humans via Discord";
    homepage = "https://github.com/KOBA789/human-in-the-loop";
    license = lib.licenses.mit;
    mainProgram = "human-in-the-loop";
  };
}
