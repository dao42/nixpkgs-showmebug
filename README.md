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
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs-unstable  # 最新版的包一般会优先在这个通道
nix-channel --update
```
2. 更改build 缓存
```
sudo vi /etc/nix/nix.conf
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
nix-channel --add https://github.com/dao42/nixpkgs-showmebug/archive/main.tar.gz  nixpkgs-showmebug
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

## 本地代理

基于nginx文件服务器，对与下载比较慢的文件进行托管。
```
http://106.52.58.179:8080
```

### 基于本地代理的nix-channel设置

终端执行添加channel：
```
#nix-channel --add http://106.52.58.179:8080/nixpkgs-showmebug/{branch|commit etc.}.tar.gz  nixpkgs-showmebug
nix-channel --add http://106.52.58.179:8080/nixpkgs-showmebug/nixpkgs-showmebug-feature-change-url-to-local-nginx.tar.gz  nixpkgs-showmebug
nix-channel --update
```

使用时直接在nix文件头部指定channel
```nix
{ pkgs ? import <nixpkgs-showmebug> {} }:
    # 环境设置表达式
```
## 支持语言说明

| 序号 |                 支持语言                  |       支持LSP       |     支持测试用例     |                    预置环境                    |
| :--: | :-------------------------------------: | :----------------: | :----------------: | :------------------------------------------: |
|  1   |           [bash](doc/bash.md)           |                    |                    |                                              |
|  2   |            [C++](doc/C++.md)            | :white_check_mark: | :white_check_mark: |         [C++](doc/C++.md#preset-env)         |
|  3   |         [C language](doc/Clang.md)      | :white_check_mark: | :white_check_mark: |      [C language](doc/Clang.md#preset-env)       |
|  4   |           [Java](doc/Java.md)           | :white_check_mark: | :white_check_mark: |        [Java](doc/Java.md#preset-env)        |
|  5   |         [NodeJS](doc/NodeJS.md)         | :white_check_mark: | :white_check_mark: |                                              |
|  6   |     [TypeScript](doc/TypeScript.md)     | :white_check_mark: | :white_check_mark: |                                              |
|  7   |         [Golang](doc/Golang.md)         | :white_check_mark: | :white_check_mark: |                                              |
|  8   |    [Objective-C](doc/Objective-C.md)    | :white_check_mark: |                    | [Objective-C](doc/Objective-C.md#preset-env) |
|  9   |            [PHP](doc/PHP.md)            | :white_check_mark: | :white_check_mark: |                                              |
|  10  |    [HTML/CSS/JS](doc/HTML-CSS-JS.md)    | :white_check_mark: |                    |                                              |
|  11  |          [MySQL](doc/MySQL.md)          |                    |                    |                                              |
|  12  |        [Python2](doc/Python2.md)        | :white_check_mark: | :white_check_mark: |     [Python2](doc/Python2.md#preset-env)     |
|  13  |        [Python3](doc/Python3.md)        | :white_check_mark: | :white_check_mark: |     [Python3](doc/Python3.md#preset-env)     |
|  14  |          [Ruby2](doc/Ruby2.md)          | :white_check_mark: | :white_check_mark: |       [Ruby2](doc/Ruby2.md#preset-env)       |
|  15  |          [Ruby3](doc/Ruby3.md)          | :white_check_mark: | :white_check_mark: |       [Ruby3](doc/Ruby3.md#preset-env)       |
|  16  |  [Assembly(GAS)](doc/Assembly(GAS).md)  |                    |                    |                                              |
|  17  | [Assembly(NASM)](doc/Assembly(NASM).md) |                    |                    |                                              |
|  18  |        [Clojure](doc/Clojure.md)        | :white_check_mark: |                    |                                              |
|  19  |   [CoffeeScript](doc/CoffeeScript.md)   |                    |                    |                                              |
|  20  |             [C#](doc/C#.md)             | :white_check_mark: |                    |                                              |
|  21  |           [Dart](doc/Dart.md)           | :white_check_mark: |                    |                                              |
|  22  |         [Elixir](doc/Elixir.md)         |                    |                    |                                              |
|  23  |         [Erlang](doc/Erlang.md)         | :white_check_mark: |                    |                                              |
|  24  |        [Haskell](doc/Haskell.md)        |                    |                    |                                              |
|  25  |         [Kotlin](doc/Kotlin.md)         | :white_check_mark: |                    |                                              |
|  26  |            [Lua](doc/Lua.md)            | :white_check_mark: | :white_check_mark: |                                              |
|  27  |          [OCaml](doc/OCaml.md)          |                    |                    |                                              |
|  28  |           [Perl](doc/Perl.md)           |                    |                    |                                              |
|  29  |              [R](doc/R.md)              |                    |                    |                                              |
|  30  |           [Rust](doc/Rust.md)           | :white_check_mark: | :white_check_mark: |                                              |
|  31  |          [Scala](doc/Scala.md)          |                    |                    |                                              |
|  32  |          [Swift](doc/Swift.md)          | :white_check_mark: |                    |                                              |
|  33  |   [Visual Basic](doc/VisualBasic.md)    |                    |                    |                                              |
|  34  |        [Verilog](doc/Verilog.md)        |                    | :white_check_mark: |                                              |
|  35  |           [VHDL](doc/VHDL.md)           |                    |                    |                                              |



# 参考资料

[搜索nix包](https://search.nixos.org/)

[nixpkgs 仓库](https://github.com/NixOS/nixpkgs)
[nixpkgs-replit replit仓库](https://github.com/replit/nixpkgs-replit)
[replit官网](https://replit.com/)

[nix pills](https://nixos.org/nixos/nix-pills/)

[nix-by-example](https://ops.functionalalgebra.com/nix-by-example/)

[Nix tutorial](https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/index.html)

[Nix Man Page](https://www.mankier.com/1/nix-shell#--no-build-hook)



待补充...