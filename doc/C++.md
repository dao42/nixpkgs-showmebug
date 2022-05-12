# C++ 
## 环境信息
### 环境版本
```
gcc version 11.2.0 (GCC)
``` 
### 依赖管理
使用 `nix expression` 来进行管理环境依赖。基于 `NIX_CFLAGS_COMPILE` 以及 `NIX_LDFLAGS` 环境变量寻找到所依赖的包，而环境变量的值由nix进行设定。

[相关参考](https://nixos.wiki/wiki/C)
### preset-env 
```c++
#include <cctype>
#include <cmath>
#include <ctime>
#include <queue>
#include <map>
#include <set>
#include <algorithm>
#include <climits>
#include <sstream>
#include <numeric>
#include <iterator>
#include <iomanip>
#include <utility>
#include <stack>
#include <functional>
#include <deque>
#include <complex>
#include <bitset>
#include <list>
#include <array>
#include <regex>
#include <random>
#include <unordered_set>
#include <unordered_map>
#include <openssl/ssl.h>
#include <openssl/rsa.h>
#include <openssl/x509.h>
#include <openssl/evp.h>
#include <openssl/sha.h>
#include <json/json.h>
#include <atomic>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <future>
#include <boost/any.hpp>
```

注意：这里的jsoncpp 的引入不是
```
#include <jsoncpp/json/json.h>
```
因为 `NIX_CFLAGS_COMPILE` 变量中jsoncpp的查找为 -isystem /nix/store/hsl437a9q6wf9r6wqh23h2x7n9v14b25-jsoncpp-1.9.4-dev/include

```bash
~/#: cd /nix/store/hsl437a9q6wf9r6wqh23h2x7n9v14b25-jsoncpp-1.9.4-dev/include && ls
json
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
        pkgs.gcc11
        pkgs.gnumake
        pkgs.openssl
        pkgs.sqlite
        pkgs.jsoncpp
        # unitTest
        pkgs.cunit
        pkgs.gtest
        pkgs.cmake
        pkgs.pkg-config
        pkgs.boost175
        pkgs.icu

        # lsp
        pkgs.ccls
    ];
}
```
## 预置环境脚本
无 
## 示例代码 
```c++
#include <iostream>

using namespace std;

int main()
{
  cout << "Hello, World!" << endl;
  return 0;
}
```
## 编译与运行 
```bash
compile_command: "gcc main.cpp -lstdc++"
run_command: "./a.out"
```
