# PowerShell

- .PSD1 file [Import-PowerShellDataFile](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-powershelldatafile?view=powershell-7.2)
- [Working with Files and Folders](https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2)
- [read input file in powershell and process it](https://social.technet.microsoft.com/Forums/Lync/en-US/7f542e1d-9f83-4aab-a78d-751c6164f198/read-input-file-in-powershell-and-process-it)

## Index

1. [设置环境变量](#set-env)
2. [PowerShell profile](#powershell-profile)
3. [PowerShell scripts](#powerShell-scripts)


## 1 Set Env

`Powershell` 设置环境变量:

```bash
#查看所有环境变量  
ls env:

#搜索环境变量   
ls env:NODE*

#查看单个环境变量 
$env:NODE_ENV

#添加/更新环境变量 
$env:NODE_ENV=development

#删除环境变量        
del evn:NODE_ENV
```

环境变量的设置和修改只会在当前窗口下有效，设置和修改只是临时缓存，一旦关闭命令窗口，环境变量就会失效。

如果要设置真实的环境变量，还是要经过去我的电脑->属性->更改设置->高级->环境变量，添加环境变量，注销/重启。

[Back to index](#Index)


## 2 PowerShell profile

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles


[Back to index](#Index)


## 3 PowerShell scripts

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scripts


### 3.1 Description

A script is a plain text file that contains one or more PowerShell commands. PowerShell 
scripts have a `.ps1` file extension.

Running a script is a lot like running a cmdlet. You type the path and file name of the 
script and use parameters to submit data and set options. You can run scripts on your 
computer or in a remote session on a different computer.

Writing a script saves a command for later use and makes it easy to share with others. 
Most importantly, it lets you run the commands simply by typing the script path and the 
filename. Scripts can be as simple as a single command in a file or as extensive as a 
complex program.

Scripts have additional features, such as the `#Requires` special comment, the use of 
parameters, support for data sections, and digital signing for security. You can also 
write Help topics for scripts and for any functions in the script.


### 3.2 How to run a script

Before you can run a script on Windows, you need to change the default PowerShell execution 
policy. Execution policy does not apply to PowerShell running on non-Windows platforms.

The default execution policy, `Restricted`, prevents all scripts from running, including 
scripts that you write on the local computer. For more information, see 
[about_Execution_Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

The execution policy is saved in the registry, so you need to change it only once on 
each computer.

To change the execution policy, use the following procedure.

At the command prompt, type:

```PowerShell
Set-ExecutionPolicy AllSigned
```
or

```PowerShell
Set-ExecutionPolicy RemoteSigned
```

The change is effective immediately.

To run a script, type the full name and the full path to the script file.

For example, to run the Get-ServiceLog.ps1 script in the `C:\Scripts` directory, type:

```PowerShell
C:\Scripts\Get-ServiceLog.ps1
```

To run a script in the current directory, type the path to the current directory, or use a 
dot to represent the current directory, followed by a path backslash (`.\`).

For example, to run the `ServicesLog.ps1` script in the local directory, type:

```PowerShell
.\Get-ServiceLog.ps1
```

If the script has parameters, type the parameters and parameter values after the script filename.

For example, the following command uses the ServiceName parameter of the Get-ServiceLog 
script to request a log of WinRM service activity.

```PowerShell
.\Get-ServiceLog.ps1 -ServiceName WinRM
```

As a security feature, PowerShell does not run scripts when you double-click the script 
icon in File Explorer or when you type the script name without a full path, even when the 
script is in the current directory. For more information about running commands and scripts 
in PowerShell, see 
[about_Command_Precedence](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_command_precedence).







[Back to index](#index)









