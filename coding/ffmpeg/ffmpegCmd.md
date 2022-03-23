# Most useful commands

[3个重点，20个函数分析，浅析FFmpeg转码过程](https://www.toutiao.com/a7073367816962851365/?log_from=ce03dcfd37674_1646912607840)

**************************************

本文转换结果位于 `F:\teaching\principleWindows\2021\ffmpeg-N-103814-gd098e16f09-win64-gpl\bin`

## 转换`MP4`为`mp3`格式

```batch
ffmpeg -i file.mp4 -b:a 128k file.mp3   // mp3与原视频时长相等
```

## 截取`mp3`指定时间的内容

```batch
ffmpeg -i input.mp3 -ss hh:mm:ss -t hh:mm:ss -acodec copy output.mp3
```

参数说明：
* -ss : 指定从那裡开始
* -t : 指定到那裡结束
* -acodec copy : 编码格式和来源档桉相同（就是mp3）

这方法不只是MP3可以用，其他的许多格式也都适用，只是输出档桉的副档名就要跟着改一改了。

以下举个例子，如果我想把a.mp3中的1分12秒到1分42秒的地方切出来，然后存成b.mp3，指令如下

```batch
ffmpeg -i a.mp3 -ss 00:00:00 -t 00:01:06 -acodec copy b.mp3
```

## 调整音频文件音量大小

```batch
ffmpeg -i b.mp3 -filter:a "volume=2.5" c.mp3

ffmpeg -i b.mp3 -filter:a "volume=10dB" d.mp3
```

