# Compiling tigerVNC

- [Using MSYS2 and Mingw-w64 to compile TigerVNC 64 bit on Windows 10 64 bit](https://github.com/TigerVNC/tigervnc/wiki/Compiling-TigerVNC-for-Windows)

*****************************************

## Index

1. [Install MSYS2](#install-msys2)
2. [Install prerequisite packages](#install-prerequisite-packages)
3. [Clone the TigerVNC project](#clone-the-tigervnc-project)
4. [Patch TigerVNC](#patch-tigerVNC)\
   4.1 [git am conflicts](#git-am-conflicts)\
   4.2 [git apply --reject](#git-apply)
5. [Create a build directory in the tigervnc repo](#create-a-build-directory-in-the-tigervnc-repo)
6. [Configure the build environment and run it](#configure-the-build-environment-and-run-it)
7. [Configure the tigerVNC server](#config-server) \
   7.1 [安装 TigerVNC 服务器](#install-tigervnc)
8. [配置客户端](#access-vncserver-via-ssh-tunnel)


## 1 Install MSYS2

Please refer to [MSYS2 Setup](../coding/ffmpeg/ffmpeg.md#msys2-setup) or
[msys2](msys2.md#installation)

MSYS2 is a self proclaimed "software distro and building platform for Windows". 
Please go to their website https://www.msys2.org/, download the one click 
installer and run it. 
The current msys2_64 is stalled in folder file://D:/msys2_64/.


## 2 Install prerequisite packages

After successfully installing of MSYS2, run msys2.exe to get a command shell. 
And then type to run the following commands:

```bash
pacman -Syu

pacman -S mingw-w64-x86_64-cmake

pacman -S mingw-w64-x86_64-fltk

pacman -S mingw-w64-x86_64-gnutls

pacman -S mingw-w64-x86_64-gcc

pacman -S mingw-w64-x86_64-make

pacman -S mingw-w64-x86_64-pixman

pacman -S git
```

[Back to index](#index)


## 3 Clone the TigerVNC project

```bash
git clone https://gitee.com/guideline/tigervnc.git

cd ./tigervnc/

git checkout -b build_windows 38726ce083db1a9227325bf87989513499bfa698
```

[Back to index](#index)


## 4 Patch TigerVNC

https://gitee.com/guideline/tigervnc/wikis/Compiling-TigerVNC-for-Windows

Create a file called apply.patch in the tigervnc repository folder you 
cloned. Add the above patch contents to that file. Run 
```batch
git am apply.patch 
```
in your git repository.

**apply.patch 这个文件的编码方式也可能是造成打补丁冲突的原因，仔细检查一下**

**怀疑无需打包！打包的内容似乎已经在新版本中得到更正。**

[Back to index](#index)


### 4.1 git am conflicts

执行上述命令后，返回如下错误
```batch
error: patch failed: cmake/BuildPackages.cmake:8
error: cmake/BuildPackages.cmake: patch does not apply
error: patch failed: release/tigervnc.iss.in:24
error: release/tigervnc.iss.in: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: Include required dll's in the installer.
Patch failed at 0001 Include required dll's in the installer.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
```

如是我们执行
```batch
git am --show-current-patch=diff
```
得到差异如下：
```batch
---
 cmake/BuildPackages.cmake |  7 +++++++
 release/tigervnc.iss.in   | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/cmake/BuildPackages.cmake b/cmake/BuildPackages.cmake
index 1f251929..9923e12d 100644
--- a/cmake/BuildPackages.cmake
+++ b/cmake/BuildPackages.cmake
@@ -8,6 +8,9 @@

 if(WIN32)

+find_path(TEMP_PATH libunistring-2.dll)
+set(WIN_DLL_PATH "${TEMP_PATH}" CACHE PATH "Path where Windows DLL files are located for installer.")
+
 if(CMAKE_SIZEOF_VOID_P MATCHES 8)
   set(INST_NAME ${CMAKE_PROJECT_NAME}64-${VERSION})
   set(INST_DEFS -DWIN64)
@@ -25,6 +28,10 @@ if(BUILD_WINVNC)
   set(INST_DEPS ${INST_DEPS} winvnc4 wm_hooks vncconfig)
 endif()

+if(ENABLE_GNUTLS)
+  set(INST_DEFS ${INST_DEFS} -DENABLE_GNUTLS)
+endif()
+
 configure_file(release/tigervnc.iss.in release/tigervnc.iss)

 add_custom_target(installer
diff --git a/release/tigervnc.iss.in b/release/tigervnc.iss.in
index 58501488..67dfb36e 100644
--- a/release/tigervnc.iss.in
+++ b/release/tigervnc.iss.in
@@ -24,10 +24,38 @@ LicenseFile=@CMAKE_SOURCE_DIR@\LICENCE.txt
 Name: "{sys}\config\systemprofile\Desktop"

 [Files]
+#ifndef BUILD_STATIC
+Source: "@WIN_DLL_PATH@/libintl-8.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libiconv-2.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/mgwfltknox-1.3.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/zlib1.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libjpeg-8.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libgcc_s_seh-1.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libstdc++-6.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libwinpthread-1.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+Source: "@WIN_DLL_PATH@/libpixman-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
+#ifdef ENABLE_GNUTLS
```

只好先执行下面的命令放弃当前的补丁：
```batch
git am --abort
```

**当前问题：补丁中的dll未拷贝到相应的位置：**\
`D:/msys2_64/mingw64/bin/mgwfltknox-1.3.dll`

**解决方法：**\
修改 `tigervnc/release/tigervnc.iss.in`，将第 30 行由
```batch
Source: "@WIN_DLL_PATH@/mgwfltknox-1.3.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
```
改为：
```batch
Source: "@WIN_DLL_PATH@/libfltk.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
```

[Back to index](#index)


### 4.2 git apply

Run 
```batch
git apply --reject apply.patch
```
in PowerShell. 该命令自动合并 patch 中不冲突的代码改动，
同时保留冲突的部分。这些存在冲突的改动内容会被单独存储到目标源文件的相应目录下，
以后缀为 .rej 的文件进行保存。

返回的结果如下：
```batch
Checking patch cmake/BuildPackages.cmake...
error: while searching for:
?
if(WIN32)?
?
if(CMAKE_SIZEOF_VOID_P MATCHES 8)?
  set(INST_NAME ${CMAKE_PROJECT_NAME}64-${VERSION})?
  set(INST_DEFS -DWIN64)?

error: patch failed: cmake/BuildPackages.cmake:8
error: while searching for:
  set(INST_DEPS ${INST_DEPS} winvnc4 wm_hooks vncconfig)?
endif()?
?
configure_file(release/tigervnc.iss.in release/tigervnc.iss)?
?
add_custom_target(installer?

error: patch failed: cmake/BuildPackages.cmake:25
Checking patch release/tigervnc.iss.in...
error: while searching for:
Name: "{sys}\config\systemprofile\Desktop"?
?
[Files]?
#ifdef BUILD_WINVNC?
Source: "@CMAKE_CURRENT_BINARY_DIR@\win\winvnc\winvnc4.exe"; DestDir: "{app}"; Flags: ignoreversion restartreplace; ?
Source: "@CMAKE_CURRENT_BINARY_DIR@\win\wm_hooks\wm_hooks.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace; ?
Source: "@CMAKE_CURRENT_BINARY_DIR@\win\vncconfig\vncconfig.exe"; DestDir: "{app}"; Flags: ignoreversion restartreplace; ?
#endif?
Source: "@CMAKE_CURRENT_BINARY_DIR@\vncviewer\vncviewer.exe"; DestDir: "{app}"; Flags: ignoreversion restartreplace; ?
Source: "@CMAKE_SOURCE_DIR@\README.rst"; DestDir: "{app}"; Flags: ignoreversion?

error: patch failed: release/tigervnc.iss.in:24
error: while searching for:
?
#ifdef BUILD_WINVNC?
[Tasks]?
Name: installservice; Description: "&Register new TigerVNC Server as a system service"; GroupDescription: "Server configuration:"; ?
Name: startservice; Description: "&Start or restart TigerVNC service"; GroupDescription: "Server configuration:";?
?
[Run]?

error: patch failed: release/tigervnc.iss.in:54
Applying patch cmake/BuildPackages.cmake with 2 rejects...
Rejected hunk #1.
Rejected hunk #2.
Applying patch release/tigervnc.iss.in with 2 rejects...
Rejected hunk #1.
Rejected hunk #2.
```

查看一下仓库中文件的更改情况：
```batch
git status
On branch build_windows
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        apply.patch
        cmake/BuildPackages.cmake.rej
        release/tigervnc.iss.in.rej

nothing added to commit but untracked files present (use "git add" to track)
```
可以看到没有` modified` 出现，也就是说文件更改都不成功。增加了 3 个 `Untracted files`:
`apply.patch`, `cmake/BuildPackages.cmake.rej`, `release/tigervnc.iss.in.rej`。
其中那个 `apply.patch` 是前面加上去的补丁文件，后两个则是冲突文件。

在 MSys2 中执行如下命令得到的相应结果也印证了上述判断：
```batch
jiche@gpuPower MSYS ~/tigervnc
$ find -name *.rej
./cmake/BuildPackages.cmake.rej
./release/tigervnc.iss.in.rej
```


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

Start MSYS2-MinGW 64 bit

```bash
cd tigervnc/build

cmake -G "MinGW Makefiles" ../

mingw32-make.exe
```

```bash
export PATH=/d/InnoSetup6/:$PATH

mingw32-make.exe installer
```

如何使用参考官方文档 https://tigervnc.org/doc/x0vncserver.html

[Back to index](#index)


## 7 配置服务器 {#config-server}

[在Ubuntu 20.04服务器上安装TigerVNC并配置VNC的详细步骤](https://ywnz.com/linuxyffq/8969.html)

********************************

在配置VNC前，必须了解VNC的运行机制。Linux下的VNC可以同时启动多个vncserver，
各个 vncserver 之间用显示编号(display number)来区分，每个vncserver服务监听3个端口，
它们分别是： 
- 5800+显示编号: 　VNC的httpd监听端口，如果VNC客户端为IE,Firefox等非vncviewer时必须开放。 
- 5900+显示编号: 　VNC服务端与客户端通信的真正端口，必须无条件开放。 
- 6000+显示编号: 　X监听端口，可选。 

显示编号、开放的端口分别由 `/etc/sysconfig/vncservers`文件中的 `VNCSERVERS` 
和 `VNCSERVERARGS` 控制。
- `VNCSERVERS` 的设置方式为 \
“VNCSERVERS=" 显示编号1:用户名1 …"”，如：\
VNCSERVERS="1:root 2:aiezu"。
- VNCSERVERARGS的设置方式为 \
VNCSERVERARGS[显示编号1]="参数一 参数值一 参数二 参数值二? ……"，如 \
VNCSERVERARGS[2]="-geometry 800x600 -nohttpd"

VNCSERVERARGS的详细参数有：
- geometry 桌面分辨率,默认1024x768； 
- nohttpd 不监听HTTP端口(58xx端口)； 
- nolisten tcp 不监听X端口(60xx端口)； 
- localhost 只允许从本机访问； 
- AlwaysShared 默认只同时允许一个vncviewer连接，此参数允许同时连多个vncviewer； 
- SecurityTypes None 登录不需要密码认证VncAuth默认值,要密码认证。 
- AcceptPointerEvents=0 客户端不允许控制server桌面 


### 7.1 安装 TigerVNC 服务器 {#install-tigervnc}

#### Step 1. 更新系统

```batch
apt-get update -y apt-get upgrade -y
```

#### Step 2. 安装 gnome 环境相关

```batch
sudo apt-get install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```

#### Step 3. 安装 vncserver

输入以下命令以安装软件包：
```batch
sudo apt install tigervnc-standalone-server
```

#### Step 4. 设置 vnc 登录密码

使用vncpasswd命令设置用户密码，运行以下命令时请勿使用sudo：
```batch
vncpasswd
```

系统将提示您输入并确认密码，以及是否将其设置为只读密码。如果选择设置仅查看密码，
则用户将无法使用鼠标和键盘与VNC实例进行交互：
```batch
Password:
Verify:

Would you like to enter a view-only password (y/n)? n
```
密码文件存储在~/.vnc目录中，如果不存在则创建该目录。

#### Step 5. 启动 vncserver

生成 .vnc 文件和 xstartup 文件

#### Step 6. 修改 .vnc/xstartup 文件

#### Step 7. 启动 vncserver

[Back to index](#index)


## 8 配置客户端 {#access-vncserver-via-ssh-tunnel}

打开 Windows PowerShell，输入命令：

```batch
ssh -X -Y -C -g -L 5906:localhost:5901 UserName@RemoteHost
```

这些ssh命令参数的含义分别是：

5906：是Destination port,即目标端口

5901: 是Source port,就是源端口,是RemoteHost上的端口.

UserName：是远程主机上的用户名

RemoteHost：是远程主机的域名或IP地址.

-C：请求压缩所有数据;

-g：允许远程主机连接主机的转发端口;

-l：指定连接远程服务器登录用户名;

-X：开启X11转发功能;

-Y：开启信任X11转发功能。

这里是我的输入：

```batch
ssh -X -Y -C -g -L 5901:localhost:5901 jicheng@ip_of_jichengVM
```

[Back to index](#index)

