# ʹ�� FFMPEG ������ҳ��Ƶ

- [ffmpeg�÷�С�ᣬ����ץ������վ��Ƶ](https://www.cnblogs.com/yangzhili/p/10014639.html)
- [ffmpeg ����_���ʹ��FFmpeg��ת������Ƶ��ͷ���ţ�](https://blog.csdn.net/weixin_39520353/article/details/110654461)
- [��ҳ��Ƶ��4�ַ���](http://www.360doc.com/content/20/0525/10/2879261_914407059.shtml)

**********************************

���Ľ���ʹ�� ffMPEG ץȡһ��ĳ���Ӱ����Ϊ����ԳF12���Թ������Ǳز����ٵĹ��ߣ�
���ڷ������´�½��get.json���ڼ�ܶ�Ⱥ���Լ�����Ȥ������һֱQ����������ģ������Ǿ仰�������㲻���������棬
�������������������������ffmpeg��ǿ��

ffmpeg ������Ϊһ������������ý�����ˡ������˷ǳ��Ƚ�����Ƶ/��Ƶ������ libavcodec��
Ϊ�˱�֤�߿���ֲ�Ժͱ����������libavcodec ��ܶ� code ���Ǵ�ͷ�����ġ�

ͨ����˵��ý�嶼��ͨ�� m3u8 ��ý��Э�鴫��ģ���ô��� m3u8 ������ʲô�����ᣬ����һ�� m3u8 �ļ������ӣ�

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

�����ļ��ֱ������ļ�����Ƭ��EXTINF ��ʾ����Ƭ��ʱ����URL��ַ�������ļ���ַ��

�������۷���ĳ���������Ƶ��һ�ַ�ʽ���ֵģ�

��һ�֣����ɻ���ĺ�PC�ͻ��˿������صĶ�����ͨ��m3u8+ffmpeg�ϲ����ص����أ�

�ڶ��֣���Ȩԭ�򲻿����ص�Ƭ�Ӷ��Ǳ�����get.json���ļ��еģ�

ffmpeg ��װ��Ϻ�������������Ƿ�ɹ���`ffmpeg -version`





