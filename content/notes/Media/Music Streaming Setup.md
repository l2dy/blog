---
up: 
related: 
created: 2023-10-21
tags:
---
# Why

Storage on a mobile device is limited. With streaming, you can enjoy higher sound quality and more tracks.

# Server Software

## Navidrome

Community has written a K8s Deployment manifest with Ingress.

https://github.com/navidrome/navidrome/blob/59f0c487e7e6943668c47321ef863291401f4a08/contrib/k8s/manifest.yml

Database can be backed up with [[Litestream]].

# Audio Codec

## Generation Loss

Transcoding from a *lossy* format might degrade the audio quality.

To avoid transcoding from lossy formats in the streaming process, store music files in either lossless formats or a codec that has the least generation loss (no transcoding is best, e.g. exclusive mode apps on Windows) in the last mile before DAC.

## Opus

`libopus` has the best quality in popular lossy formats supported by FFmpeg. [Encode/HighQualityAudio](https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio)

For audible transparency, use 128 kbps for stereo. [Opus Recommended Settings](https://wiki.xiph.org/Opus_Recommended_Settings)

Stereo 160 to 192 kbps is verified transparent according to https://wiki.hydrogenaud.io/index.php?title=Opus.

## AAC

Apple Music's default import function uses 256 kbps VBR AAC for stereo music.

For audible transparency, use 128 kbps for stereo.

Minimal generation loss could be one of the design goals of AAC. [Reference](https://hydrogenaud.io/index.php/topic,100067.msg828555.html#msg828555)

### FFmpeg Transcode

#### `libfdk_aac`

For 192 kbps **VBR**, use `-vbr 5` with `-c:a libfdk_aac`. VBR also disables the low-pass filter and preserves higher frequencies.

`git log v2.0.2..` in https://github.com/mstorsjo/fdk-aac shows improvements in security hardening and VBR encoding, so it's worth a try.

you can install FFmpeg with MacPorts.

```bash
port install ffmpeg6 +nonfree
```

#### `aac_at`

https://wiki.hydrogenaud.io/index.php?title=Apple_AAC

For FFmpeg, `q` is read from `avctx->global_quality` and `127 - q * 9` is passed to the AudioToolbox framework and `q` ranges from `0` to `14`.

For 256 kbps **VBR**, use `-q:a 2`. Do not use `-global_quality:a`, which is ineffective and gives a constant 128 kbps.

A 3 minute long music file transcoded with  `-vn -c:a aac_at -q:a <q in filename>` gives the following file sizes.

```
$ du -k q*.m4a # unit is kiB
8196	q0.m4a
6404	q2.m4a
5380	q4.m4a
4100	q5.m4a
3844	q6.m4a
3588	q7.m4a
```

https://github.com/FFmpeg/FFmpeg/blob/393d1ee541b143633bfba2ff0e821d734fd511c2/libavcodec/audiotoolboxenc.c#L325-L335

### AAC Generation Loss

https://www.reddit.com/r/AppleMusic/comments/o67idh/losslesshires_lossless_on_airpods_pro/h2sshj5/

> The thing here is that, yeah there's an increase, because previously you had a lossy file (AAC) which lose again info thanks to the BT AAC codec, there's two compressions to the file, now you only have one compression the BT AAC one, so there's less info loss it during the process.

> It's decoded, mixed with system sounds (like alerts) and then recompressed. This is obvious because the output over bluetooth rolls off high-frequencies a bit sooner than the original AAC file. (I think the test I saw was on The Sound Guy's website, but I can't find it now)
>
> The good news is that the generational loss from AAC to Uncompressed to AAC again is really minor. You can do it over and over and its still very difficult for people to tell the difference between the original AAC file and its descendant.
