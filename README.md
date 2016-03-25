shadowsocks-local
=================

Build `shadowsocks-local` in China.

Since golang.org is blocked in China, the `go get ...` method does not work.
So I cached all deps to the `vendor/` directory.

If you don't trust the `vendor/` directory and want to make it manually,
just run `./get-vendor.sh`.

To get Linux version on a Mac, build it in a Docker container:

```
docker run --rm -v "$PWD:/go/src/github.com/caiguanhao/shadowsocks-local" \
  -w "/go/src/github.com/caiguanhao/shadowsocks-local" golang:1.5.0 go build -v
```
