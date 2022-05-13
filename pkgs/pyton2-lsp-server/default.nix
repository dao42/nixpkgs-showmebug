{ lib
, autopep8
, buildPythonPackage
, fetchFromGitHub
, flake8
, flaky
, jedi
, matplotlib
, mccabe
, numpy
, pandas
, pluggy
, pycodestyle
, pydocstyle
, pyflakes
, pylint
, pyqt5
, pytestCheckHook
, python-lsp-jsonrpc
, pythonOlder
, rope
, setuptools
, ujson
, yapf
}:

buildPythonPackage rec {
  pname = "python-lsp-server";
  version = "1.2.4";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "python-lsp";
    repo = pname;
    rev = "v${version}";
    sha256 = "0c1g46hpzjhqbjcmv6xm3by3jprcjhzjslqzrp95hdkbykvrgs5x";
  };

  postPatch = ''
    substituteInPlace setup.cfg \
      --replace "--cov-report html --cov-report term --junitxml=pytest.xml" "" \
      --replace "--cov pylsp --cov test" ""
  '';

  propagatedBuildInputs = [
    jedi
    pluggy
    python-lsp-jsonrpc
    setuptools
    ujson
    rope
    yapf
  ];

  checkInputs = [
    flaky
    matplotlib
    numpy
    pandas
    pyqt5
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$(mktemp -d);
  '';

  pythonImportsCheck = [ "pylsp" ];
}