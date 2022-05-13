# Java 
## 环境信息 
### 环境版本
```
openjdk 17.0.3 2022-04-19
OpenJDK Runtime Environment (build 17.0.3+7-nixos)
OpenJDK 64-Bit Server VM (build 17.0.3+7-nixos, mixed mode, sharing)
```
### 依赖管理
**注意** 这里的路径是指nix环境中的路径

依赖存放路径：`$HOME/.m2`
这部分分为两个部分：项目依赖以及单文件依赖

1. 项目依赖

通过 maven 进行依赖, 前提是需要有 `pom.xml`， 安装的依赖会存放在 `$HOME/.m2/repository`

2. 单文件依赖

通过 `wget/curl` 进行下载, 将下载的依赖存放在 `$HOME/.m2/lib`， 并设置环境变量， 

```bash
export CLASSPATH=$CLASSPATH:$HOME/.m2/lib
```
### preset-env 
```java
import java.io.*;
import java.util.*;
import java.math.*;
import java.util.regex.*;
import java.util.stream.*;
import java.text.*;
import java.security.SecureRandom;
import java.util.function.*;
import java.util.concurrent.*;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.core.type.*;
import com.fasterxml.jackson.databind.*;
```
## nix-shell
```nix
{ pkgs ? import <nixpkgs-showmebug> {} }:
pkgs.mkShell {
    shellHook = ''
        alias ll="ls -l"
        export PS1="\[\e[0m\]\w\[\e[0m\]#\[\e[0m\] "
        export LC_ALL=en_US.UTF-8
        export CLASSPATH=$CLASSPATH:$HOME/.m2/lib
    '';
    packages = [
        # env
        pkgs.jdk
        pkgs.maven
        pkgs.glibcLocales
        # lsp
        pkgs.replitPackages.jdt-language-server
    ];
}
``` 
## 预置环境脚本

java-env-set.sh
```bash
# !/bin/bash
# Something wrong will lead exit.
set -eo pipefail

# 友好输出安装信息，进行输出日志的颜色提示
black=0
red=1
green=2
yellow=3
blue=4
cyan=5
white=6


__usage="
  Usage: $(basename $0) [OPTIONS]

  sh java-env-set.sh language package_path outdir

  Options:
    language                     eg. java python etc.
    package_path                 所要安装的包文件路径 eg. ./package.txt
    outdir                       相应环境的包的存储路径 eg. ./lib
"
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "$__usage"
else
  # get command input
  language=$1
  filepath=$2
  outdir=$3

  if [ ! -d "$outdir" ]; then
    mkdir -p $outdir
  fi

  echo "$(tput setaf $yellow)当前正在安装 $language 相关依赖...\n"

  # read file
  while IFS= read -r line || [ -n "$line" ] ; do
    pname="$(basename -- $line)"
    echo "$(tput setaf $blue)当前正在安装package -- $pname:\n"

    if [ -f "$outdir/$pname" ]; then
      echo "$(tput setaf $green)当前package -- $pname 已经安装:\n"
      continue
    fi

    # download package
    curl $line --output $pname  && mv $pname $outdir

  done < "$filepath"
  echo "$(tput setaf $green)$language 相关依赖安装成功!\n"
fi
```

java-packages.txt
```
https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.6.2/junit-platform-console-standalone-1.6.2.jar
https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.11.4/jackson-core-2.11.4.jar 
https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.12.1/jackson-databind-2.12.1.jar
```

执行脚本
```bash
sh java-env-set.sh java java-packages.txt $HOME/.m2/lib 
```

也可下载在其他目录，通过挂载的方式使得nix环境下的 `$HOME/.m2/lib` 存有相关依赖

## 示例代码
Main.java
```java
import java.util.*;

// 必须定义 `ShowMeBug` 入口类和 `public static void main(String[] args)` 入口方法
public class Main {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
}
``` 
## 编译与运行
```bash
run_command: "java Main.java"
``` 

