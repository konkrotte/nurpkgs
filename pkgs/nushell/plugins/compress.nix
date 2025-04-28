{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  bzip2,
  xz,
  zstd,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_compress";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "yybit";
    repo = "nu_plugin_compress";
    rev = version;
    hash = "sha256-sm26bkBgZqPWaCUJxQqKiA8M/eROh6sCnIRrgxbJPTo=";
  };

  cargoHash = "sha256-4M+wGEnRGsvk2S8Dt3fqjDM3jkNfj0mnQTTcWs6oJ/4=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    [
      bzip2
      xz
      zstd
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.IOKit
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
