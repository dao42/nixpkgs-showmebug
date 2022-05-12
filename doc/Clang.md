# Clang 
## 环境信息 
### 环境版本 
```
clang version 12.0.1
```
### 依赖管理
使用 `nix expression` 来进行管理环境依赖。基于 `NIX_CFLAGS_COMPILE` 以及 `NIX_LDFLAGS` 环境变量寻找到所依赖的包，而环境变量的值由nix进行设定。

[相关参考](https://nixos.wiki/wiki/C)
### 预置环境 
```c
#include <stdatomic.h>
#include <stdatomic.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#include <openssl/ssl.h>
#include <openssl/rsa.h>
#include <openssl/x509.h>
#include <openssl/evp.h>
#include <openssl/sha.h>
#include <pthread.h>
#include <unistd.h>
```
## nix-shell 
```nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    shellHook = ''
      alias ll="ls -l"
      export PS1="\[\e[0m\]\w\[\e[0m\]#\[\e[0m\] "
    '';
    packages = [
      # env
      pkgs.clang_12
      pkgs.gdb
      pkgs.gnumake
      pkgs.openssl
      pkgs.file
      # lsp
      pkgs.ccls
    ];
}
```
## 预置环境脚本
无 
## 示例代码 
```c
#include <stdio.h>
#include <stdlib.h>

int main()
{
  printf("Hello, World!\n");
  return 0;
}
```
## 编译与运行 
```bash
compile_command: "clang main.c"
run_command: "./a.out"
```


