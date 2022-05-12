{ sources ? import nix/sources.nix
, channel ? sources."nixpkgs-21.11"
}:
import channel {overlays = [ (import ./overlay.nix) ];}
