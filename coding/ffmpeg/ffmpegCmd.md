# Most useful commands


## ת��`MP4`Ϊ`mp3`��ʽ

```batch
ffmpeg -i file.mp4 -b:a 128k file.mp3   // mp3��ԭ��Ƶʱ�����
```

## ��ȡ`mp3`ָ��ʱ�������

```batch
ffmpeg -i input.mp3 -ss hh:mm:ss -t hh:mm:ss -acodec copy output.mp3
```

����˵����
* -ss : ָ�������e��ʼ
* -t : ָ�������e����
* -acodec copy : �����ʽ����Դ������ͬ������mp3��

�ⷽ����ֻ��MP3�����ã�����������ʽҲ�����ã�ֻ���������ĸ�������Ҫ���Ÿ�һ���ˡ�

���¾ٸ����ӣ���������a.mp3�е�1��12�뵽1��42��ĵط��г�����Ȼ����b.mp3��ָ������

```batch
ffmpeg -i a.mp3 -ss 00:00:00 -t 00:01:06 -acodec copy b.mp3
```

## ������Ƶ�ļ�������С

```batch
ffmpeg -i b.mp3 -filter:a "volume=2.5" c.mp3

ffmpeg -i b.mp3 -filter:a "volume=10dB" d.mp3
```

