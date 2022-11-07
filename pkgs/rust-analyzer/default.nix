{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  pname = "rust-analyzer";
  version = "2022-05-17";
  
  src = fetchurl {
    url = "http://106.52.58.179:8080/language-source/rust/rust-analyzer";
    sha256 = "sha256-W7zkpNT1ca0SqIrqnhW+wm1kroM3+sI/Sos93m+eDcA=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin
    mv $out/bin/*-rust-* $out/bin/rust-analyzer
    cd $out/bin &&  chmod +x rust-analyzer
  '';
}