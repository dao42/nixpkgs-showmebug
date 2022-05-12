# nixpkgs-showmebug

`nixpkgs-showmebug` is Showmebug's nixpkgs overlay. This overlay provides several
[channels](https://nixos.wiki/wiki/Nix_channels) that track the upstream nix
channels of the same name.

## nix 环境预置

[安装 nix](https://nix.dev/tutorials/install-nix) 

[安装 niv](https://github.com/nmattia/niv)

设置国内代理
1. 更新channel

```
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-21.11-darwin  nixpkgs
nix-channel --update
```
2. 更改build 缓存
```
sudo vi /etc/nix/nix.conf#
# 最后一行添加
substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/
```

## 本地使用
可以通过添加channel的方式进行使用。利用 `GITHUB ARCHIVE` 生成gz文件，格式如下：
1. 利用分支

```
https://github.com/dao42/nixpkgs-showmebug/archive/{branch}.tar.gz
```

2. 利用commit

```
https://github.com/dao42/nixpkgs-showmebug/archive/{commit}.tar.gz
```

3. 发布release

```
https://github.com/dao42/nixpkgs-showmebug/archive/refs/tags/{tag}.tar.gz
```

终端执行添加channel：
```
nix-channel --add https://github.com/dao42/nixpkgs-showmebug/archive/main.tar.gz  showmebug-nixpkgs
nix-channel --update
```

编写shell.nix
```nix
{ pkgs ? import <nixpkgs-showmebug> {} }:
pkgs.mkShell {
    shellHook = ''
        alias ll="ls -l"
        export PS1="\[\e[0m\]\w\[\e[0m\]#\[\e[0m\] "
    '';
    packages = [
        # env
        pkgs.php74
        pkgs.php74Packages.composer
        pkgs.showmebugPackages.phpunit
    ];
}
```

 执行 `nix-shell` 进入到php环境 

 备注： 初次执行比较慢，可通过 `nix-shell -v` 查看日志，另外后续进入时，为避免从substituters查询，可以使用
 `nix-shell --no-substitute` 快速进入shell环境



