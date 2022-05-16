{ stdenv, fetchFromGitHub, php74, composer }:
stdenv.mkDerivation rec {
  pname = "php-language-server";
  version = "5.4.6.1";
  
  src = fetchFromGitHub {
    owner = "dao42";
    repo = pname;
    rev = "v${version}";
    sha256 = "0qzin0fcwgnrwdvxpwaibjlzbiv8c6hifgi2jgrbgasj2sz9zvbp";
  };

  buildInputs = [
    php74
    composer
  ];

  installPhase = ''
    composer install
    mkdir $out && cp -r . $out
  '';
}