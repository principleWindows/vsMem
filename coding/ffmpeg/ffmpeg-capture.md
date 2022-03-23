# 使用 FFMPEG 捕获网页视频

- [ffmpeg用法小结，教你抓各大网站视频](https://www.cnblogs.com/yangzhili/p/10014639.html)
- [ffmpeg 参数_如何使用FFmpeg玩转西瓜视频和头条号？](https://blog.csdn.net/weixin_39520353/article/details/110654461)
- [网页视频的4种方法](http://www.360doc.com/content/20/0525/10/2879261_914407059.shtml)

**********************************

本文介绍使用 ffMPEG 抓取一段某酷电影。作为程序猿F12调试工具我们必不可少的工具，
终于发现了新大陆（get.json）期间很多群友以及感兴趣的朋友一直Q我如何做到的，还是那句话授人以鱼不如授人以渔，
下面就让我们切入正题领略下ffmpeg的强大。

ffmpeg 可以作为一个轻量级的流媒体服务端。包含了非常先进的音频/视频编解码库 libavcodec，
为了保证高可移植性和编解码质量，libavcodec 里很多 code 都是从头开发的。

通常来说流媒体都是通过 m3u8 流媒体协议传输的，那么这个 m3u8 究竟是什么东西尼，来看一个 m3u8 文件的例子：

```txt
#EXTM3U
#EXT-X-TARGETDURATION:12
#EXT-X-VERSION:3
#EXTINF:2.794,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=0.0&ts_end=2.694&ts_seg_no=0&ts_keyframe=1
#EXTINF:6.006,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=2.694&ts_end=8.7&ts_seg_no=1&ts_keyframe=1
#EXTINF:5.965,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=8.7&ts_end=14.665&ts_seg_no=2&ts_keyframe=1
#EXTINF:10.677,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=14.665&ts_end=25.342&ts_seg_no=3&ts_keyframe=1
#EXTINF:11.97,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=25.342&ts_end=37.312&ts_seg_no=4&ts_keyframe=1
#EXTINF:11.053,
http://124.232.154.138/697DF29874035830935FE95C58/0300012B00514AEBC5AF0C055EEB3EEBD6129C-A3C1-DDE4-FC72-B43E9E4BA0CB.flv.ts?ccode=0503&duration=8310&expire=18000&psid=6ad2cfe028b8c575d768527c1a7492e0&ups_client_netip=6a244247&ups_ts=1542543506&ups_userid=86396328&utid=xsnLEvIve08CAXuLhlY4DLPH&vid=XNDcyOTk1ODIw&s=1655b27abceb11e0bf93&iv=1&sp=&vkey=Aeaaa3b8e9d8d7f29010ef443a2d41a07&ts_start=37.312&ts_end=48.365&ts_seg_no=5&ts_keyframe=1
#EXT-X-ENDLIST
```

以上文件种保存了文件的切片，EXTINF 表示该切片的时长，URL地址就是流文件地址。

几经周折发现某酷的它的视频是一种方式呈现的：

第一种：凡可缓存的和PC客户端可以下载的都可以通过m3u8+ffmpeg合并下载到本地；

第二种：版权原因不可下载的片子都是保存在get.json的文件中的；

ffmpeg 安装完毕后，下面命令检验是否成功：`ffmpeg -version`





