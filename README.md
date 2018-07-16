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
docker run -it --rm -v ~/Downloads:/data jaysong/aria2:1.34.0 -M something.meta4
```
