# Tips for Windows

<https://social.technet.microsoft.com/Forums/zh-cn/home>


## Clearing Disk C

* C:/Windows/Temp
* C:/SoftwareDistribution/Download
* C:\Windows\System32\LogFiles/
* C:\Windows\Prefetch

## Powershell

[Understanding Windows Console Host Settings](https://devblogs.microsoft.com/commandline/understanding-windows-console-host-settings/)

禁用 win10 自动创建的虚拟连接后, 在文件夹窗口中启动 Powershell 会陷入长久等待而失败。原因未知。


## cd /d

Going back to the days of DOS, there's a separate "current directory" for each drive. 
`cd D:\foldername` changes the current directory of disk D to the foldername specified, 
but does not change the fact that you're still working on the current drive.
With `/D` option `cd /d D:\foldername` changes the current DRIVE in addition to 
changing folder.


## Remote Desktop Multi-Monitor

[How to Set the Monitor for a Remote Desktop Session in a Multi-Monitor Setup](https://social.technet.microsoft.com/wiki/contents/articles/665.how-to-set-the-monitor-for-a-remote-desktop-session-in-a-multi-monitor-setup.aspx)

用文本编辑器打开 .rdp 文件，手工调整其中的一些参数即可。

这些参数的用途介绍可以参考这里：

具体来说，需要调整其中的 WINDOWPOS  参数，这个参数的用途和可以调整的内容可以参考这里：

https://msdn.microsoft.com/zh-cn/library/ms632612.aspx 

在远程桌面连接工具中，输入主机名、用户名，以及其他连接参数后，在“常规”选项卡下点击“另存为”，即可将当前的连接信息保存为一个 .rdp 文件

<https://answers.microsoft.com/zh-hans/windows/forum/all/%E5%9C%A8%E4%B8%89%E5%8F%B0%E6%98%BE%E7%A4%BA/2af6af4f-83d3-44ba-a84b-8d490262fa58?auth=1>



