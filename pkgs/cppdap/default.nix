{ stdenv,fetchurl }:
stdenv.mkDerivation rec {
  pname = "cppdap";
  version = "2022091901";
  
  src = fetchurl {
    url = "http://106.52.58.179:8080/debug/cppdap-2022091901.tar.gz";
    sha256 = "sha256:1h0yydqy5602sxb5wjwj0fkbf5jb9lavj7f24r3yf7hiipwjiggw";
  };



  installPhase = ''
    mkdir -p $out/bin
    cp -r ./bin/* $out/bin
  '';

  dontStrip = true;
}