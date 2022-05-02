# msys2 - git

- [Install inside MSYS2 proper](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper)
- [如何优雅地配置 Windows 环境下的 MSys2 + Git 开发环境？](https://zhuanlan.zhihu.com/p/33751738)

*************************************

## Index

1. [Introduction](#introduction)
2. [The steps](#the-steps) \
   [2.1 Step 1](#step-1) \
   [2.2 Step 2](#step-2) \
   [2.3 Step 3](#step-3)
3. [How to use?](#how-to-use)

![](pix/MSYS2-Icon.png)


## 1 Introduction

Git for Windows being based on MSYS2, it's possible to install the 
mingw-w64-git package into an existing MSYS2 installation. That means 
that if you are already using MSYS2 on your computer, you can use Git 
for Windows without running the full installer or using the portable 
version. There are some caveats for going this way, details below.

This guide assumes you are comfortable using the command line and you 
are willing to completely re-install your MSYS2 if something goes wrong. 


[Back to index](#index)


## 2 The steps

Here are the steps to install the 64-bit version of Git for Windows to be 
run in an MSYS2 terminal (msys2_shell.cmd):

**下面的步骤未能成功完成，正确的做法见[Update MSys2](msys2.md#update-msys2)**

### 2.1 Step 1

Edit `/etc/pacman.conf` and add the Git for Windows package repositories 
above any others (i.e. just before [mingw32] on line #71 as of this writing):

```batch
[git-for-windows]
Server = https://wingit.blob.core.windows.net/x86-64

[git-for-windows-mingw32]
Server = https://wingit.blob.core.windows.net/i686
```
(The above is correct. The second, MINGW-only repository is for the other 
architecture.)

This step can be done with the following sed command (make sure to do proper 
backup before trying it):
```batch
sed -i '/^\[mingw32\]/{ s|^|[git-for-windows]\nServer = https://wingit.blob.core.windows.net/x86-64\n\n[git-for-windows-mingw32]\nServer = https://wingit.blob.core.windows.net/i686\n\n|; }' /etc/pacman.conf
```


[Back to index](#index)


### 2.2 Step 2

Authorize the signing key with:
```batch
curl -L https://185.199.110.133/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |
pacman-key --add - &&
pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C &&
pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986

curl -L https://raw.githubusercontent.com/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |
pacman-key --add - &&
pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C &&
pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986
```


[Back to index](#index)


### 2.3 Step 3

Then synchronize with new repositories with

```batch
pacman -Syyuu
```
This installs a new `msys2-runtime` and therefore will ask you to 
terminate all MSYS2 processes. Save what you need from other open 
`MSYS2` shells and programs, exit them and confirm the Pacman prompt. 
Double-check Task Manager and kill `pacman.exe` if it's still running 
after the window is closed. Start a new MSYS2 terminal.



[Back to index](#index)


