{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  stdenv,
  darwin,
  wayland,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_clipboard";
  version = "0.101.0";

  src = fetchFromGitHub {
    owner = "FMotalleb";
    repo = "nu_plugin_clipboard";
    rev = version;
    hash = "sha256-qS8dOtOLq8grhmori9w1d/zrhu1X3Qk51y+v/LTAxO8=";
  };

  cargoHash = "sha256-JO5Ye08AvMIGS3rSY/hGHKH+7BymmGbhZwCnnJeFdFo=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.AppKit
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.IOKit
    ]
    ++ lib.optionals stdenv.isLinux [
      wayland
    ];

  meta = {
    description = "A nushell plugin to copy text into clipboard or get text from it. supports json<->object/table conversion out of box";
    homepage = "https://github.com/FMotalleb/nu_plugin_clipboard";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "nu_plugin_clipboard";
  };
}
