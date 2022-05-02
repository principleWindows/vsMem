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
   7.1 [��װ TigerVNC ������](#install-tigervnc)
8. [���ÿͻ���](#access-vncserver-via-ssh-tunnel)


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

**apply.patch ����ļ��ı��뷽ʽҲ��������ɴ򲹶���ͻ��ԭ����ϸ���һ��**

**����������������������ƺ��Ѿ����°汾�еõ�������**

[Back to index](#index)


### 4.1 git am conflicts

ִ����������󣬷������´���
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

��������ִ��
```batch
git am --show-current-patch=diff
```
�õ��������£�
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

ֻ����ִ����������������ǰ�Ĳ�����
```batch
git am --abort
```

**��ǰ���⣺�����е�dllδ��������Ӧ��λ�ã�**\
`D:/msys2_64/mingw64/bin/mgwfltknox-1.3.dll`

**���������**\
�޸� `tigervnc/release/tigervnc.iss.in`������ 30 ����
```batch
Source: "@WIN_DLL_PATH@/mgwfltknox-1.3.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
```
��Ϊ��
```batch
Source: "@WIN_DLL_PATH@/libfltk.dll"; DestDir: "{app}"; Flags: ignoreversion restartreplace;
```

[Back to index](#index)


### 4.2 git apply

Run 
```batch
git apply --reject apply.patch
```
in PowerShell. �������Զ��ϲ� patch �в���ͻ�Ĵ���Ķ���
ͬʱ������ͻ�Ĳ��֡���Щ���ڳ�ͻ�ĸĶ����ݻᱻ�����洢��Ŀ��Դ�ļ�����ӦĿ¼�£�
�Ժ�׺Ϊ .rej ���ļ����б��档

���صĽ�����£�
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

�鿴һ�²ֿ����ļ��ĸ��������
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
���Կ���û��` modified` ���֣�Ҳ����˵�ļ����Ķ����ɹ��������� 3 �� `Untracted files`:
`apply.patch`, `cmake/BuildPackages.cmake.rej`, `release/tigervnc.iss.in.rej`��
�����Ǹ� `apply.patch` ��ǰ�����ȥ�Ĳ����ļ������������ǳ�ͻ�ļ���

�� MSys2 ��ִ����������õ�����Ӧ���Ҳӡ֤�������жϣ�
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

���ʹ�òο��ٷ��ĵ� https://tigervnc.org/doc/x0vncserver.html

[Back to index](#index)


## 7 ���÷����� {#config-server}

[��Ubuntu 20.04�������ϰ�װTigerVNC������VNC����ϸ����](https://ywnz.com/linuxyffq/8969.html)

********************************

������VNCǰ�������˽�VNC�����л��ơ�Linux�µ�VNC����ͬʱ�������vncserver��
���� vncserver ֮������ʾ���(display number)�����֣�ÿ��vncserver�������3���˿ڣ�
���Ƿֱ��ǣ� 
- 5800+��ʾ���: ��VNC��httpd�����˿ڣ����VNC�ͻ���ΪIE,Firefox�ȷ�vncviewerʱ���뿪�š� 
- 5900+��ʾ���: ��VNC�������ͻ���ͨ�ŵ������˿ڣ��������������š� 
- 6000+��ʾ���: ��X�����˿ڣ���ѡ�� 

��ʾ��š����ŵĶ˿ڷֱ��� `/etc/sysconfig/vncservers`�ļ��е� `VNCSERVERS` 
�� `VNCSERVERARGS` ���ơ�
- `VNCSERVERS` �����÷�ʽΪ \
��VNCSERVERS=" ��ʾ���1:�û���1 ��"�����磺\
VNCSERVERS="1:root 2:aiezu"��
- VNCSERVERARGS�����÷�ʽΪ \
VNCSERVERARGS[��ʾ���1]="����һ ����ֵһ ������ ����ֵ��? ����"���� \
VNCSERVERARGS[2]="-geometry 800x600 -nohttpd"

VNCSERVERARGS����ϸ�����У�
- geometry ����ֱ���,Ĭ��1024x768�� 
- nohttpd ������HTTP�˿�(58xx�˿�)�� 
- nolisten tcp ������X�˿�(60xx�˿�)�� 
- localhost ֻ����ӱ������ʣ� 
- AlwaysShared Ĭ��ֻͬʱ����һ��vncviewer���ӣ��˲�������ͬʱ�����vncviewer�� 
- SecurityTypes None ��¼����Ҫ������֤VncAuthĬ��ֵ,Ҫ������֤�� 
- AcceptPointerEvents=0 �ͻ��˲��������server���� 


### 7.1 ��װ TigerVNC ������ {#install-tigervnc}

#### Step 1. ����ϵͳ

```batch
apt-get update -y apt-get upgrade -y
```

#### Step 2. ��װ gnome �������

```batch
sudo apt-get install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```

#### Step 3. ��װ vncserver

�������������԰�װ�������
```batch
sudo apt install tigervnc-standalone-server
```

#### Step 4. ���� vnc ��¼����

ʹ��vncpasswd���������û����룬������������ʱ����ʹ��sudo��
```batch
vncpasswd
```

ϵͳ����ʾ�����벢ȷ�����룬�Լ��Ƿ�������Ϊֻ�����롣���ѡ�����ý��鿴���룬
���û����޷�ʹ�����ͼ�����VNCʵ�����н�����
```batch
Password:
Verify:

Would you like to enter a view-only password (y/n)? n
```
�����ļ��洢��~/.vncĿ¼�У�����������򴴽���Ŀ¼��

#### Step 5. ���� vncserver

���� .vnc �ļ��� xstartup �ļ�

#### Step 6. �޸� .vnc/xstartup �ļ�

#### Step 7. ���� vncserver

[Back to index](#index)


## 8 ���ÿͻ��� {#access-vncserver-via-ssh-tunnel}

�� Windows PowerShell���������

```batch
ssh -X -Y -C -g -L 5906:localhost:5901 UserName@RemoteHost
```

��Щssh��������ĺ���ֱ��ǣ�

5906����Destination port,��Ŀ��˿�

5901: ��Source port,����Դ�˿�,��RemoteHost�ϵĶ˿�.

UserName����Զ�������ϵ��û���

RemoteHost����Զ��������������IP��ַ.

-C������ѹ����������;

-g������Զ����������������ת���˿�;

-l��ָ������Զ�̷�������¼�û���;

-X������X11ת������;

-Y����������X11ת�����ܡ�

�������ҵ����룺

```batch
ssh -X -Y -C -g -L 5901:localhost:5901 jicheng@ip_of_jichengVM
```

[Back to index](#index)

