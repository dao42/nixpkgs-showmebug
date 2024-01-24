#!/bin/sh
npx -y node2nix -16 --version
npx -y node2nix -16 -i node-packages.json --registry https://registry.npmmirror.com
nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt .'
