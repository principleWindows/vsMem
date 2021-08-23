# FFmpegInterop library for Windows

<https://github.com/microsoft/FFmpegInterop>

<https://trac.ffmpeg.org/wiki/CompilationGuide>

<https://windowsforum.com/threads/using-ffmpeg-in-windows-applications.210173/>

[FFmpegInteropX library for Windows](https://github.com/ffmpeginteropx/FFmpegInteropX)

*************************************

## What is FFmpeg / FFmpegInterop / FFmpegInteropX?

[FFmpeg](https://www.ffmpeg.org/) is a free, open-source multimedia framework that includes 
a set of tools which can be used by end users for transcoding, streaming, and playing, as 
well as a set of libraries for developers to use in applications. These libraries are 
valuable to developers as they add support for virtually all media formats including .mkv, 
.flv, and .mov. Projects that use FFmpeg libraries include Google Chrome, VLC, and 
[many more](https://trac.ffmpeg.org/wiki/Projects).

FFmpegInterop is an open-source project that aims to provide an easy way to use FFmpeg 
in Windows 10. FFmpegInteropX is an open-source project that aims to provide an easy 
way to use FFmpeg in Windows 10 UWP Apps.

FFmpegInterop implements a [MediaStreamSource](https://msdn.microsoft.com/en-us/library/windows/apps/windows.media.core.mediastreamsource.aspx) 
which leverages FFmpeg to process media and uses the Windows media pipeline for playback.

## Prerequisites

Getting a compatible build of FFmpeg is required for this to work.

You can simply use the embedded git submodule that points to the latest tested release of FFmpeg.

```batch
git clone --recursive git://github.com/microsoft/FFmpegInterop.git
```

Your `FFmpegInterop` folder should look as follows

```dir
FFmpegInterop\
    ffmpeg\              - ffmpeg source code from the latest release in git://github.com/FFmpeg/FFmpeg.git
    FFmpegInterop\       - FFmpegInterop WinRT component
    Samples\             - Sample Media Player applications in C++, C#, and JavaScript
    Tests\               - Unit tests for FFmpegInterop
    BuildFFmpeg.bat      - Helper script to build FFmpeg libraries as described in https://trac.ffmpeg.org/wiki/CompilationGuide/WinRT
    FFmpegConfig.sh      - Internal script that contains FFmpeg configure options
    FFmpegWin8.1.sln     - Microsoft Visual Studio 2013 solution file for Windows 8.1 and Windows Phone 8.1 apps development
    FFmpegWin10.sln      - Microsoft Visual Studio 2015 solution file for Windows 10 apps development
    LICENSE
    README.md
```

Now that you have the FFmpeg source code, you can follow the instructions on how to build 
[FFmpeg for WinRT apps](https://trac.ffmpeg.org/wiki/CompilationGuide/WinRT). 
Follow the setup instruction carefuly to avoid build issues. 

### Compile and Use FFmpeg Libraries for Windows 10 Runtime

<https://trac.ffmpeg.org/wiki/CompilationGuide/WinRT>

The configuration requires a distinct set of tools, environment variables, and configure 
options. And in this subsection we will conclude with some practical and potentially 
non-obvious information for consuming the FFmpeg DLLs from your win10 app.

#### Prerequisites

* ​MSYS2 (GNU Make environment)
* ​YASM (x86 assembly code compiler)
* ​gas-preprocessor.pl (ARM assembly pre-processor)

#### MSYS2 Setup

Download the installer: [msys2-x86_64-latest.tar.xz](msys2-x86_64-latest.tar.xz)
Extract to run the installer. (folder file://D:/msys64/)

Download the installer: [msys2-x86_64-latest.exe](msys2-x86_64-latest.exe)
Click to run the installer. Choose to intall on disk D ( folder file://D:/msys2_64/, 
do NOT install on disk C ).

Update the package database and base packages. Unless your setup file is very recent, 
it will take two steps. First run pacman -Syu on MSYS2 MinGW 64-bit:

![pacman -Syu](pix/pacman-Syu.PNG)

Run "MSYS2 MSYS" from Start menu. Update the rest of the base packages with pacman -Su:

![pacman -Su](pix/pacman-Su.PNG)


Once base MSYS2 is successfully installed, get the latest make package by invoking the 
following command in your MSYS2 shell:

![pacman -S make](pix/pacman_-S_make.PNG)

Now MSYS2 is ready for you. You will probably want to install some tools and the 
mingw-w64 GCC to start compiling:

`pacman -S --needed base-devel mingw-w64-x86_64-toolchain`

Also get the latest gcc package:

![pacman -S gcc](pix/pacman_-S_gcc.PNG)

**Rename link.exe**, in the MSYS2 usr bin folder (E.g. D:\msys2_64\usr\bin\link.exe), 
to be **link_msys.exe** to prevent conflict with MSVC link.exe

Install perl as it will be needed to run 'gas-preprocessor.pl':

`pacman -S perl`

![pacman -S perl](pix/pacman_-S_perl.PNG)

Install also diffutils for configure script:

`pacman -S diffutils`

![pacman -S diffutils](pix/pacman_-S_diffutils.PNG)


```batch
pacman -S nasm 							#汇编工具,安装
pacman -S yasm 							#汇编工具,安装
pacman -S make 							#项目编译工具,必须安装
pacman -S cmake 						#项目编译工具,必须安装
pacman -S diffutils 					#比较工具,ffmpeg configure 生成makefile时会用到,若不安装会警告,最好是安装
pacman -S pkg-config					#库配置工具,编译支持x264和x265用到
pacman -S git							#下载源码用,可以不安装,可自行通过其它方式下载源码
```

After completing the setup as instructed, you can invoke BuildFFmpeg.bat script to build or 
do it manually using the instructions in the compilation guide.


## Compiling for Windows 10 x64

Launch VS2019 x86_x64 Cross Tools Command Prompt. E.g.

```batch
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2019\Visual Studio Tools\VC\x86_x64 Cross Tools Command Prompt for VS 2019
```

Set the following environment variables in the launched command prompt above:

```batch
SET LIB=%VSINSTALLDIR%VC\lib\store\amd64;%VSINSTALLDIR%VC\atlmfc\lib\amd64;%UniversalCRTSdkDir%lib\%UCRTVersion%\ucrt\x64;;%UniversalCRTSdkDir%lib\%UCRTVersion%\um\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\lib\um\x64;;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\Lib\um\x64
SET LIBPATH=%VSINSTALLDIR%VC\atlmfc\lib\amd64;%VSINSTALLDIR%VC\lib\amd64;
SET INCLUDE=%VSINSTALLDIR%VC\include;%VSINSTALLDIR%VC\atlmfc\include;%UniversalCRTSdkDir%Include\%UCRTVersion%\ucrt;%UniversalCRTSdkDir%Include\%UCRTVersion%\um;%UniversalCRTSdkDir%Include\%UCRTVersion%\shared;%UniversalCRTSdkDir%Include\%UCRTVersion%\winrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\Include\um;
```

Open MSYS2 Shell from the command prompt above (use the correct drive and location of 
your MSYS2 installation). Note that the command shell above will close and it may take a 
while for the MSYS2 shell to launch.

<https://blog.csdn.net/ihmhm12345/article/details/109645568>

```batch
cd D:\msys2_64
set MSYS2_PATH_TYPE=inherit
msys2_shell.cmd
```

`set MSYS2_BIN="D:\msys2_64\usr\bin\bash.exe"`

![](pix/x86_x64_cross_tools.PNG)

In your MSYS2 shell navigate to your cloned FFmpeg folder. E.g.

```batch
cd /F/mygit/FFmpegInterop/ffmpeg
```

Invoke the following make commands:

```batch
mkdir -p Output/Windows10/x64

cd Output/Windows10/x64

../../../configure \
--toolchain=msvc \
--disable-programs \
--disable-d3d11va \
--disable-dxva2 \
--arch=x86_64 \
--enable-shared \
--enable-cross-compile \
--target-os=win32 \
--extra-cflags="-MD -DWINAPI_FAMILY=WINAPI_FAMILY_APP -D_WIN32_WINNT=0x0A00" \
--extra-ldflags="-APPCONTAINER WindowsApp.lib" \
--prefix=../../../Build/Windows10/x64

make

make install
```









