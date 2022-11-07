{ stdenv, fetchurl, jdk }:
stdenv.mkDerivation rec {
  pname = "kotlin-language-server";
  version = "1.3.0";
  
  src = fetchurl {
    url = "http://106.52.58.179:8080/language-source/kotlin/server.tar.gz";
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