{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "dlb-mp4base";
  version = "unstable-2022-02-15";

  src = fetchFromGitHub {
    owner = "DolbyLaboratories";
    repo = "dlb_mp4base";
    rev = "8da6d4a8fc095a88349fbdac33e7e68fb3b93649";
    hash = "sha256-mLo9rPgMkGjhMGqpH4wZKBTQxQef7J+Ox288qBuzJug=";
  };

  sourceRoot = ".";

  # Create expected directory structure
  preBuildPhase = ''
    # Create dlb_mp4base directory and link source files
    mkdir -p dlb_mp4base
    ln -s $PWD/source/frontend dlb_mp4base/frontend
    ln -s $PWD/source/source dlb_mp4base/source
    ln -s $PWD/source/include dlb_mp4base/include

    # Create build directories
    mkdir -p source/make/mp4muxer/macos/obj/mp4muxer_release
    mkdir -p source/make/mp4muxer/macos/bin
  '';

  buildPhase = ''
    cd source/make/mp4muxer/macos
    make mp4muxer_release \
      DLBMP4BASE_DIR=$PWD/../../../../dlb_mp4base
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp source/make/mp4muxer/macos/bin/mp4muxer $out/bin/dlb-mp4base
  '';

  meta = {
    description = "The Dolby MP4 streaming muxer (dlb_mp4base) is a software implementation of a muxer of fragmented or unfragmented ISO base media file format (mp4). It supports muxing of Dolby Digital (AC-3), Dolby Digital Plus (E-AC-3), and Dolby AC-4 audio formats as well as Dolby Vision";
    homepage = "https://github.com/DolbyLaboratories/dlb_mp4base";
    license = lib.licenses.bsd3;
    maintainers = [ ];
    mainProgram = "dlb-mp4base";
    platforms = lib.platforms.all;
  };
}
