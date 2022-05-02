# TeXLive

[How to install mathgifg package](https://tex.stackexchange.com/questions/129819/how-to-install-mathgifg-package)

<https://ctan.math.washington.edu/tex-archive/macros/latex/contrib/brandeis-thesis/>


## 1 Download

Download mirrors list for cn:
https://ctan.org/mirrors/mirmon#cn

location for the setup file:
https://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/install-tl-windows.exe


## 2 Installation

click the downloaded `install-tl-windows.exe`

![TeXLive installer](pix/texlive_installer.png)

Follow the instruction to complete the installation.

Run the following commands to check the installation status:
```batch
tex -v
latex -v
xelatex -v
pdflatex -v
```

Reload Visual Studio so that the environment path being updated.


## 3 Configuration

Copy `tasks.vs.json` to the `.vs` folder of your project root working space.
Create a new folder `textemp` in your project root working space,  
and make sure to add `textemp/` to your `.ignore` file.


## 4 Tips


### 4.1 Extract a .cls from a .dtx

```batch
latex F:\Projects\yabee\git\auto-locator\textemp\erdc\erdc.ins
```

### 4.2 环境错误处理 (#bailout)

若右键运行 latex 出错，先尝试删除所有暂时生成的中间文件，再次尝试运行。



