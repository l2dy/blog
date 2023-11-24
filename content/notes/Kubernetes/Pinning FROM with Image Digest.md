---
up: 
related: 
created: 2023-10-02
tags:
---
## Using multi-platform base images

The digest shown on Docker Hub is platform-specfic. When you click on a tag, it brings you to the first architecture only.

To get digest of the entire multi-platform image, you could use `nerdctl` as shown below or `docker buildx imagetools inspect <image>:<tag>`.

```
$ nerdctl image inspect --mode native bitnami/pgbouncer:1.20.1
[..snip..]
"Image": {
    "Name": "docker.io/bitnami/pgbouncer:1.20.1",
    "Labels": null,
    "Target": {
        "mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
        "digest": "sha256:710da11a466f98b90380fb8e02b487aacf8ef33b07acabb402067c122ac63e8d",
        "size": 529
    },
    "CreatedAt": "2023-10-02T14:54:49.666483Z",
    "UpdatedAt": "2023-10-02T14:54:49.666483Z"
},
```