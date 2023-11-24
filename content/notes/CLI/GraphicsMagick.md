---
up: 
related: 
created: 2023-11-12
tags:
---
```sh
# Make thumbnail of an image
gm convert -size 120x120 a.jpg -resize 120x120 +profile "*" thumbnail.jpg

# Report image info
gm identify -verbose a.jpg
```
