{ lib, stdenv, fetchFromGitHub, }:

stdenv.mkDerivation rec {
  pname = "dlb-mp4base";
  version = "unstable-2022-02-15";

  src = fetchFromGitHub {
    owner = "DolbyLaboratories";
    repo = "dlb_mp4base";
    rev = "8da6d4a8fc095a88349fbdac33e7e68fb3b93649";
    hash = "sha256-mLo9rPgMkGjhMGqpH4wZKBTQxQef7J+Ox288qBuzJug=";
  };

  meta = {
    description =
      "The Dolby MP4 streaming muxer (dlb_mp4base) is a software implementation of a muxer of fragmented or unfragmented ISO base media file format (mp4). It supports muxing of Dolby Digital (AC-3), Dolby Digital Plus (E-AC-3), and Dolby AC-4 audio formats as well as Dolby Vision";
    homepage = "https://github.com/DolbyLaboratories/dlb_mp4base";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dlb-mp4base";
    platforms = lib.platforms.all;
  };
}
