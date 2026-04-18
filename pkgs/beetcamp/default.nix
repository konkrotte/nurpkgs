{
  lib,
  python3,
  fetchFromGitHub,
  pkgs,
}:

let
  poetry-core-2 = python3.pkgs.poetry-core.overridePythonAttrs (_: rec {
    version = "2.1.3";
    src = fetchFromGitHub {
      owner = "python-poetry";
      repo = "poetry-core";
      rev = version;
      hash = "sha256-CgaWlqjvBTN7GuerzmO5IiEdXxYH6pmTDj9IsNJlCBE=";
    };
    doCheck = false;
  });
in
python3.pkgs.buildPythonApplication rec {
  pname = "beetcamp";
  version = "0.24.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "snejus";
    repo = "beetcamp";
    rev = version;
    hash = "sha256-kKFYuTJys4j67+cak2PDmn6z2vNzVitFXIZXy2bClY8=";
  };

  build-system = [ poetry-core-2 ];

  preBuild = ''
    HOME=$PWD
  '';

  nativeBuildInputs = [ pkgs.beets ];

  dependencies = [ pkgs.beets ] ++ (with python3.pkgs; [
    httpx
    ordered-set
    packaging
    pycountry
  ]);

  pythonImportsCheck = [ "beetsplug.bandcamp" ];

  meta = {
    description = "Bandcamp autotagger source for beets (https://beets.io";
    homepage = "https://github.com/snejus/beetcamp";
    changelog = "https://github.com/snejus/beetcamp/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl2Only;
    maintainers = [ ];
    mainProgram = "beetcamp";
  };
}
