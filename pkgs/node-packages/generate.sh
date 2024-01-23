#!/bin/sh
nix-shell -p nodePackages.node2nix --run 'node2nix -14 --version'
nix-shell -p nodePackages.node2nix --run 'node2nix -14 -i node-packages.json --registry https://registry.npmmirror.com'
nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt .'

