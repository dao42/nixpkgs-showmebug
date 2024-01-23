self: super:

with super.lib;

let
  nodePackages = self.callPackage ./pkgs/node-packages {
      nodejs = super."nodejs-14_x";
    };

  repomap = nodePackages."repomap-0.0.3".override {
      nativeBuildInputs = [ nodePackages."prebuild-install-7.1.1" ];
      preBuild = ''
        npm config set registry https://registry.npmmirror.com
      '';
    };

  # We have our own version of typescript-language-server here because the version in upstream nixpkgs
  # has a bug which is causing issues for code intelligence in node repls.
  # Copied from nixpkgs:
  # https://cs.github.com/NixOS/nixpkgs/blob/529ce4161a07f0b5a4a6d6cc4339d50f7cec77b5/pkgs/development/node-packages/default.nix#L474-L480
  typescript-language-server = nodePackages."typescript-language-server-0.9.6".override {
      nativeBuildInputs = [ self.makeWrapper ];
      postInstall = ''
        wrapProgram "$out/bin/typescript-language-server" \
          --suffix PATH : ${self.lib.makeBinPath [ self.nodePackages.typescript ]} \
          --add-flags "--tsserver-path ${self.nodePackages.typescript}/lib/node_modules/typescript/lib/"
      '';
    };
in
{

  nodePackages = super.nodePackages // {
    inherit typescript-language-server;
    inherit repomap;
    
  };

  replitPackages = rec {
    # Version string set when building overlay
    version = "GIT_SHA_HERE";

    # Any other packages should go in the replitPackages namespace
    replbox = self.callPackage ./pkgs/replbox { };

    jdt-language-server = self.callPackage ./pkgs/jdt-language-server { };
    java-debug = self.callPackage ./pkgs/java-debug {
      inherit jdt-language-server;
    };

    rescript-language-server = self.callPackage ./pkgs/rescript-language-server { };
    nbcode = self.callPackage ./pkgs/nbcode { };

    jest = nodePackages."jest-cli-23.6.0";
    coffeescript = nodePackages."coffeescript-2.6.1";

    basil = self.callPackage ./pkgs/basil { };

    # Also included typescript-language-server so hydra will build it for us.
    inherit typescript-language-server;

    # The override packages are injected into the replitPackages namespace as
    # well so they can all be built together
  } // self.pkgs.lib.optionalAttrs (self.pkgs ? graalvm17-ce) {
    java-language-server = self.callPackage ./pkgs/java-language-server { };
  };

  paaspkgs = rec {
    phpunit = self.callPackage ./pkgs/phpunit { };
    rust-analyzer = self.callPackage ./pkgs/rust-analyzer { };

    php74 = super.php74;
    composer = super.php74Packages.composer;

    php-language-server = self.callPackage ./pkgs/php-language-server { 
      php74 = php74;
      composer = composer;
    };
    
    jdk = super.jdk;
    kotlin-language-server = self.callPackage ./pkgs/kotlin-language-server { 
      jdk = jdk;
    };
    cppdap = self.callPackage ./pkgs/cppdap { };

    rfbproxy = self.callPackage ./pkgs/rfbproxy { };
  };

  showmebugPackages = self.paaspkgs;

}

