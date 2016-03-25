#!/bin/bash

set -e

SHADOWSOCKS_GO_COMMIT=1.1.4
CHACHA20_COMMIT=ec07b4f69a3f70b1dd2a8ad77230deb1ba5d6953
CRYPTO_COMMIT=c197bcf24cde29d3f73c7b4ac6fd41f4384e8af6

rm -rf vendor
mkdir -p vendor

if test ! -d vendor/shadowsocks-go-$SHADOWSOCKS_GO_COMMIT; then
  echo "getting shadowsocks-go-$SHADOWSOCKS_GO_COMMIT..."
  curl -Ls https://github.com/shadowsocks/shadowsocks-go/archive/$SHADOWSOCKS_GO_COMMIT.tar.gz | \
    tar -C vendor -xvzf - shadowsocks-go-$SHADOWSOCKS_GO_COMMIT/shadowsocks
fi

if test ! -d vendor/chacha20-$CHACHA20_COMMIT; then
  echo "getting chacha20-$CHACHA20_COMMIT..."
  curl -Ls https://github.com/codahale/chacha20/archive/$CHACHA20_COMMIT.tar.gz | tar -C vendor -xvzf -
fi

grep --include "*.go" -lrF "github.com/codahale/chacha20" vendor | \
  xargs sed -i "" "s,github.com/codahale/chacha20,github.com/caiguanhao/shadowsocks-local/vendor/chacha20-$CHACHA20_COMMIT,"

if test ! -d vendor/crypto-$CRYPTO_COMMIT; then
  echo "getting crypto-$CRYPTO_COMMIT..."
  curl -Ls https://github.com/golang/crypto/archive/$CRYPTO_COMMIT.tar.gz | \
    tar -C vendor -xvzf - crypto-$CRYPTO_COMMIT/blowfish crypto-$CRYPTO_COMMIT/cast5 crypto-$CRYPTO_COMMIT/salsa20/salsa
fi

grep --include "*.go" -lrF "golang.org/x/crypto" vendor | \
  xargs sed -i "" "s,golang.org/x/crypto,github.com/caiguanhao/shadowsocks-local/vendor/crypto-$CRYPTO_COMMIT,"
