## One-Liners

### Detect encoding errors

```sh
ffmpeg -err_detect explode -i <infile> -f null -
```

### Convert music file to Opus format

```sh
find . -type f -name '*.flac' | parallel 'test -f {.}.opus || ffmpeg -i {} -vn -c:a libopus -b:a 192k {.}.opus'
```

### Keep Display Aspect Ratio when Downsampling

```sh
ffmpeg -i in.mp4 -vf "setsar='if(sar,sar,1)',scale=640x480" out.mp4
```