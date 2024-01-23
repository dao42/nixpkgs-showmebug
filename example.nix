{ pkgs ? import <nixpkgs> { overlays = [(import /etc/nix/nixpkgs-showmebug/overlay.nix)];} }:
{
    pkgs.mkShell = {
        shellHook = ''
            alias ll="ls -l"
            export PS1="\[\e[0m\]\w\[\e[0m\]#\[\e[0m\] "
            export LANG=en_US.UTF-8
            export npm_config_prefix="$HOME/app/.config/npm/node_global"
            export PATH=$HOME/app/node_modules/.bin:$npm_config_prefix/bin:$PATH
        '';
        packages = [
            # env
            pkgs.nodejs-18_x
            # lsp
            pkgs.nodePackages.typescript-language-server
            pkgs.glibcLocales
        ];
    };
    
    programs.git = {
        enable = true;
        userName  = "sengmitnick";
        userEmail = "sengmitnick@163.com";
    };
}

