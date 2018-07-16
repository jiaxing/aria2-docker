# aria2

Dockerfile for the [`jaysong/aria2:1.34.0`](https://hub.docker.com/r/jaysong/aria2/)
Docker Hub image.

## Feature:

- [`aria2`](https://github.com/aria2/aria2)
- A mount point is created at `/data` is the default download directory.
- A mount point is created at `/config/aria2` and contains the default aria2.conf which sets the download directory as `/data`.

## How To Download:
- Metalink
```
docker run -d --rm -v ~/Downloads:/data jaysong/aria2:1.34.0 -M something.meta4
```

- Override aria2.conf
```
docker run -it --rm -v ~/Downloads:/data -v ~/.aria2/aria2.conf:/config/aria2/aria2.conf jaysong/aria2:1.34.0 -M something.meta4
```
