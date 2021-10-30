# Tips for Windows

<https://social.technet.microsoft.com/Forums/zh-cn/home>


## Clearing Disk C

* C:/Windows/Temp
* C:/SoftwareDistribution/Download
* C:\Windows\System32\LogFiles/
* C:\Windows\Prefetch

## Powershell

[Understanding Windows Console Host Settings](https://devblogs.microsoft.com/commandline/understanding-windows-console-host-settings/)

���� win10 �Զ��������������Ӻ�, ���ļ��д��������� Powershell �����볤�õȴ���ʧ�ܡ�ԭ��δ֪��


## cd /d

Going back to the days of DOS, there's a separate "current directory" for each drive. 
`cd D:\foldername` changes the current directory of disk D to the foldername specified, 
but does not change the fact that you're still working on the current drive.
With `/D` option `cd /d D:\foldername` changes the current DRIVE in addition to 
changing folder.


## Remote Desktop Multi-Monitor

[How to Set the Monitor for a Remote Desktop Session in a Multi-Monitor Setup](https://social.technet.microsoft.com/wiki/contents/articles/665.how-to-set-the-monitor-for-a-remote-desktop-session-in-a-multi-monitor-setup.aspx)

���ı��༭���� .rdp �ļ����ֹ��������е�һЩ�������ɡ�

��Щ��������;���ܿ��Բο����

������˵����Ҫ�������е� WINDOWPOS  �����������������;�Ϳ��Ե��������ݿ��Բο����

https://msdn.microsoft.com/zh-cn/library/ms632612.aspx 

��Զ���������ӹ����У��������������û������Լ��������Ӳ������ڡ����桱ѡ��µ�������Ϊ�������ɽ���ǰ��������Ϣ����Ϊһ�� .rdp �ļ�

<https://answers.microsoft.com/zh-hans/windows/forum/all/%E5%9C%A8%E4%B8%89%E5%8F%B0%E6%98%BE%E7%A4%BA/2af6af4f-83d3-44ba-a84b-8d490262fa58?auth=1>



