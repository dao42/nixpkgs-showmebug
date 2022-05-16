{ stdenv, fetchurl, jdk }:
stdenv.mkDerivation rec {
  pname = "kotlin-language-server";
  version = "1.3.0";
  
  src = fetchurl {
    url = "https://github.com/dao42/kotlin-language-server/releases/download/1.3.1/server.tar.gz";
    sha256 = "sha256-DApQaZN0smwEdyd+YWKSiJJwCkb9uFac547N3RGwAWk=";
  };

  buildInputs = [
    jdk
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./bin/* $out/bin
    cp -r ./li* $out
  '';
}