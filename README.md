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

If you want to run a shadowsocks Docker container for other app to use:

```
vim config.json
# {
#   "server": "jp5.0bad.com",
#   "server_port": 29546,
#   "local_port": 1080,
#   "password": "xxxxxxxxxxxxxxxxxxxx",
#   "method": "aes-128-cfb",
#   "timeout": 600
# }

docker-compose build
docker-compose up -d
```

And then link the container in other apps:

```
docker run --rm --link=shadowsockslocal_client_1:ss node:5.0.0 curl -s --socks ss ip.cn
// 当前 IP：161.202.83.153 来自：日本 SoftLayer
```
