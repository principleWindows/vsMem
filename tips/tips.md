# Tips for VS

[Use the Microsoft C++ toolset from the command line](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160)

[MSBuild on the command line - C++](https://docs.microsoft.com/en-us/cpp/build/msbuild-visual-cpp?view=msvc-160)

[MSBuild](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019)

[vc/vs工程命令行编译](https://my.oschina.net/u/4000302/blog/3271118)

[Create C++ cross-platform projects](https://docs.microsoft.com/en-us/cpp/build/get-started-linux-cmake?view=msvc-160)

[Cross Platform C++ Development](https://devblogs.microsoft.com/cppblog/using-visual-studio-for-cross-platform-c-development-targeting-windows-and-linux/)

[Linux && arm cross compaling in visual studio code](https://cloudstack.ninja/bochra-akrout/linux-arm-cross-compaling-in-visual-studio-code/)

[最好的 Windows C++ 编译器！](https://baijiahao.baidu.com/s?id=1645352405560402772&wfr=spider&for=pc)

***************************

## 1 Build from the Command Line

You can build C and C++ applications on the command line by using tools that are included 
in Visual Studio. The Microsoft C++ (MSVC) compiler toolset is also downloadable as a 
standalone package. You don't need to install the Visual Studio IDE if you don't plan to use it.

> **Note**
>
> This article is about how to set up an environment to use the individual compilers, 
linkers, librarian, and other basic tools. The native project build system, MSBuild, 
does not use the environment as described in this article. For more information on how 
to use MSBuild from the command line, see 
[MSBuild on the command line - C++](https://docs.microsoft.com/en-us/cpp/build/msbuild-visual-cpp?view=msvc-160).

### 1.1 Download and install the tools

If you've installed Visual Studio and a C++ workload, you have all the command-line tools. 
For information on how to install C++ and Visual Studio, see 
[Install C++ support in Visual Studio](https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-160). 
If you only want the command-line toolset, download the 
[Build Tools for Visual Studio](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019). 
When you run the downloaded executable, it updates and runs the Visual Studio Installer. 
To install only the tools you need for C++ development, select the C++ build tools workload. 
You can select optional libraries and toolsets to include under Installation details. To build 
code by using the Visual Studio 2015 or 2017 toolsets, select the optional MSVC v140 or 
MSVC v141 build tools. When you're satisfied with your selections, choose Install.

### 1.2 How to use the command-line tools

When you choose one of the C++ workloads in the Visual Studio Installer, it installs the 
Visual Studio platform toolset. A platform toolset has all the C and C++ tools for a specific 
Visual Studio version. The tools include the C/C++ compilers, linkers, assemblers, and other 
build tools, and matching libraries. You can use all of these tools at the command line. 
They're also used internally by the Visual Studio IDE. There are separate x86-hosted and 
x64-hosted compilers and tools to build code for x86, x64, ARM, and ARM64 targets. Each set 
of tools for a particular host and target build architecture is stored in its own directory.

To work correctly, the tools require several specific environment variables to be set. These 
variables are used to add the tools to the path, and to set include file, library file, and 
SDK locations. To make it easy to set these environment variables, the installer creates 
customized command files, or batch files, during installation. You can run one of these 
command files to set a specific host and target build architecture, Windows SDK version, 
and platform toolset. For convenience, the installer also creates shortcuts in your Start 
menu. The shortcuts start developer command prompt windows by using these command files for 
specific combinations of host and target. These shortcuts ensure all the required environment 
variables are set and ready to use.

The required environment variables are specific to your installation and to the build 
architecture you choose. They also might be changed by product updates or upgrades. That's 
why we recommend you use an installed command prompt shortcut or command file, instead of 
setting the environment variables yourself.

The toolsets, command files, and shortcuts installed depend on your computer processor and 
the options you selected during installation. The x86-hosted tools and cross tools that build 
x86 and x64 code are always installed. If you have 64-bit Windows, the x64-hosted tools and 
cross tools that build x86 and x64 code are also installed. If you choose the optional C++ 
Universal Windows Platform tools, then the x86 and x64 tools that build ARM and ARM64 code 
also get installed. Other workloads may install these and other tools.

### 1.3 Path and environment variables for command-line builds

The MSVC command-line tools use the `PATH`, `TMP`, `INCLUDE`, `LIB`, and `LIBPATH` 
environment variables, and also use other environment variables specific to your installed 
tools, platforms, and SDKs. Even a simple Visual Studio installation may set twenty or more 
environment variables. The values of these environment variables are specific to your 
installation and your choice of build configuration, and can be changed by product updates 
or upgrades. That's why we strongly recommend that you use a 
[developer command prompt shortcut](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160#developer_command_prompt_shortcuts) 
or one of the [customized command files](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160#developer_command_file_locations) 
to set them. We don't recommend you set them in the Windows environment yourself.

To see which environment variables are set by a developer command prompt shortcut, you can use 
the `SET` command. Open a plain command prompt window and capture the output of the `SET` 
command for a baseline. Open a developer command prompt window and capture the output of the 
`SET` command for comparison. A diff tool such as the one built into the Visual Studio IDE can 
be useful to compare the environment variables and see what's set by the developer command 
prompt. For information about the specific environment variables used by the compiler and linker, 
see [CL Environment Variables](https://docs.microsoft.com/en-us/cpp/build/reference/cl-environment-variables?view=msvc-160).

### 1.4 Developer command prompt shortcuts

The command prompt shortcuts are installed in a version-specific Visual Studio folder in your 
Windows Start menu. Here's a list of the base command prompt shortcuts and the build 
architectures they support:

* Developer Command Prompt - Sets the environment to use 32-bit, x86-native tools to build 32-bit, x86-native code.
* x86 Native Tools Command Prompt - Sets the environment to use 32-bit, x86-native tools to build 32-bit, x86-native code.
* x64 Native Tools Command Prompt - Sets the environment to use 64-bit, x64-native tools to build 64-bit, x64-native code.
* x86_x64 Cross Tools Command Prompt - Sets the environment to use 32-bit, x86-native tools to build 64-bit, x64-native code.
* x64_x86 Cross Tools Command Prompt - Sets the environment to use 64-bit, x64-native tools to build 32-bit, x86-native code.

The Start menu folder and shortcut names vary depending on the installed version of Visual 
Studio. If you set one, they also depend on the installation Nickname. For example, suppose 
you installed Visual Studio 2019, and you gave it a nickname of Latest. The developer command 
prompt shortcut is named Developer Command Prompt for VS 2019 (Latest), in a folder named 
Visual Studio 2019.

> Note
>
>>Several command-line tools or tool options may require Administrator permission. If you 
>>have permission issues when you use them, we recommend that you open the developer command 
>>prompt window by using the Run as Administrator option. On Windows 10, right-click to open 
>>the shortcut menu for the command prompt window, then choose More, Run as administrator.



## 2 Create Cpp Cross-Platform Projects


## 3 Cross Platform C++ Development





