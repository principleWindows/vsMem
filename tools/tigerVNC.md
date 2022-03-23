# Compiling tigerVNC

- [Using MSYS2 and Mingw-w64 to compile TigerVNC 64 bit on Windows 10 64 bit](https://github.com/TigerVNC/tigervnc/wiki/Compiling-TigerVNC-for-Windows)

*****************************************

## Index

1. [Install MSYS2](#install-msys2)
2. [Install prerequisite packages](#install-prerequisite-packages)
3. [Clone the TigerVNC project](#clone-the-tigervnc-project)
4. [Patch TigerVNC](#patch-tigerVNC)
5. [Create a build directory in the tigervnc repo](#create-a-build-directory-in-the-tigervnc-repo)
6. [Configure the build environment and run it](#configure-the-build-environment-and-run-it)


## 1 Install MSYS2

Please refer to [MSYS2 Setup](../coding/ffmpeg/ffmpeg.md#msys2-setup) or
[msys2](msys2.md#installation)

MSYS2 is a self proclaimed "software distro and building platform for Windows". 
Please go to their website https://www.msys2.org/, download the one click 
installer and run it. 
The current msys2_64 is stalled in folder file://D:/msys2_64/.


## 2 Install prerequisite packages

```bash
pacman -Syu

pacman -S mingw-w64-x86_64-cmake

pacman -S mingw-w64-x86_64-fltk

pacman -S mingw-w64-x86_64-gnutls

pacman -S mingw-w64-x86_64-gcc

pacman -S mingw-w64-x86_64-make

pacman -S mingw-w64-x86_64-pixman
```

[Back to index](#index)


## 3 Clone the TigerVNC project

```bash
git clone https://github.com/TigerVNC/tigervnc.git

git checkout -b build_windows 38726ce083db1a9227325bf87989513499bfa698
```

[Back to index](#index)


## 4 Patch TigerVNC

https://gitee.com/guideline/tigervnc/wikis/Compiling-TigerVNC-for-Windows


[Back to index](#index)


## 5 Create a build directory in the tigervnc repo

Start MSYS2-MinGW 64 bit

```bash
cd tigervnc

mkdir build

cd build
```


[Back to index](#index)


## 6 Configure the build environment and run it

```bash
cmake -G "MinGW Makefiles" ../

mingw32-make.exe
```



