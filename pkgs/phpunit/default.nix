{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  pname = "phpunit";
  version = "9.5.20";
  
  src = fetchurl {
    url = "http://106.52.58.179:8080/language-source/php/phpunit-9.5.20.phar";
    sha256 = "6becad2da5c37f5ad101cc665ef05a2f1a6a45d2427c8edcc74f72c92fb1e05a";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin
    mv $out/bin/*-phpunit-* $out/bin/phpunit
    cd $out/bin && chmod +x phpunit
  '';
}