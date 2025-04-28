{
  stdenv,
  lib,
  rustPlatform,
  pkg-config,
  nix-update-script,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_clipboard";
  version = "0.101.0";

  src = fetchFromGitHub {
    repo = "nu_plugin_clipboard";
    owner = "FMotalleb";
    rev = "${version}";
    hash = "sha256-qS8dOtOLq8grhmori9w1d/zrhu1X3Qk51y+v/LTAxO8=";
  };
  useFetchCargoVendor = true;
  cargoHash = "sha256-qv9lk7tR+XLwmRNxiw7I6NB2InZc5aM63EZMSBiUqr8=";

  nativeBuildInputs = [ pkg-config ] ++ lib.optionals stdenv.cc.isClang [ rustPlatform.bindgenHook ];
  cargoBuildFlags = [ "--package nu_plugin_clipboard" ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "A nushell plugin to copy text into clipboard or get text from it.";
    mainProgram = "nu_plugin_clipboard";
    homepage = "https://github.com/FMotalleb/nu_plugin_clipboard";
    license = licenses.mit;
    maintainers = [ ];
    platforms = with platforms; all;
  };
}
