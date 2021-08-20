# FFmpegInterop library for Windows

<https://github.com/microsoft/FFmpegInterop>

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

