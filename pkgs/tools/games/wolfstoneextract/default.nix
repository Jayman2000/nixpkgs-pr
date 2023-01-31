{ stdenv, lib, fetchFromBitbucket, cmake, pkg-config, libogg, libvorbis }:

stdenv.mkDerivation rec {
  pname = "wolfstoneextract";
  version = "1.2";

  src = fetchFromBitbucket {
    owner = "ecwolf";
    repo = pname;
    rev = version;
    sha256 = "yrYLP2ewOtiry+EgH1IEaxz2Q55mqQ6mRGSxzVUnJ8Q=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ libogg libvorbis ];
  cmakeFlags = [ "-DINTERNAL_OGG=OFF" "-DINTERNAL_VORBIS=OFF" ];
  postInstall = ''

  '';

  meta = {
    # description was copied from the short project description on
    # WolfstonExtract’s Bitbucket repo. longDescription was coppied from
    # WolfstoneExtract’s README. When this package is updated, we should
    # probably check those two places and update description or longDescription
    # if they’ve changed.
    description = "Utility to extract Wolfstone data from Wolfenstein II";
    longDescription = ''
      This utility extracts the game data for Wolfstone 3D from an installed
      copy of Wolfenstein II: The New Collosus, or Elite Hans: Die Neue Ordnung
      from Wolfenstein: Youngblood. To use, simply install Wolfenstein II or
      Youngblood from Steam and run the utility. It should automatically find
      your game data and produce a wolfstone.pk3 or elitehans.pk3.

      This utility does not modify the game data in any way, merely extracts the
      data from the larger data set and repacks it into a container recognizable
      by ECWolf.
    '';
    homepage = https://bitbucket.org/ecwolf/wolfstoneextract;
    downloadPage = "https://maniacsvault.net/ecwolf/download.php#wolfstone";
    changelog = "https://bitbucket.org/ecwolf/wolfstoneextract/src/${version}/changelog";
    license = with lib; [
      # TODO: Potentially change to gpl3Plus after this issue is closed:
      # <https://bitbucket.org/ecwolf/wolfstoneextract/issues/3/clarify-whether-or-not-future-versions-of>
      gpl3Only
      bsd3
    ];
  };
}
