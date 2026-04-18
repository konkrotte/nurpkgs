{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  bzip2,
  xz,
  zstd,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_compress";
  version = "0.2.10";

  src = fetchFromGitHub {
    owner = "yybit";
    repo = "nu_plugin_compress";
    rev = "30cf23253a7e47b9996445f8390be5c069707263";
    hash = "sha256-PiPlP5AkxP5IkVVY+3qQHnGqhcXraCNkohSkvKIBqW8=";
  };

  cargoHash = "sha256-96ojxb1hb8WaEtuDTHiGNOCYGJgDiCoYys/NDQlIdwc=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    bzip2
    xz
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "A nushell plugin for compression and decompression, supporting zstd, gzip, bzip2, and xz";
    homepage = "https://github.com/yybit/nu_plugin_compress";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "nu_plugin_compress";
  };
}
