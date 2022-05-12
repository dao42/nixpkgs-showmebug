# bash 
## 环境信息 
bash 环境，用于执行shell脚本
### 环境版本 
无
### 依赖管理 
无
### preset-env 
无
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
        pkgs.bash
    ];
}
```
## 预置环境脚本 
无
## 示例代码

main.sh

```bash
echo "Talk is cheap, show me the code!"
```
## 编译与运行 
无

