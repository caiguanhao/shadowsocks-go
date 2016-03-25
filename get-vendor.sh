#!/bin/bash

set -e

mkdir -p vendor

if test ! -d vendor/shadowsocks-go-1.1.4; then
  echo "getting shadowsocks-go-1.1.4..."
  curl -Ls https://github.com/shadowsocks/shadowsocks-go/archive/1.1.4.tar.gz | tar -C vendor -xzf -
fi

if test ! -d vendor/chacha20; then
  echo "getting chacha20..."
  curl -Ls https://github.com/codahale/chacha20/archive/master.tar.gz | tar -C vendor -xzf -
  mv vendor/chacha20-master vendor/chacha20
fi

grep --include '*.go' -lrF 'github.com/codahale/chacha20' vendor | \
  xargs sed -i '' 's,github.com/codahale/chacha20,github.com/caiguanhao/shadowsocks-local/vendor/chacha20,'

if test ! -d vendor/crypto; then
  echo "getting crypto..."
  curl -Ls https://github.com/golang/crypto/archive/master.tar.gz | tar -C vendor -xzf -
  mkdir -p vendor/crypto
  mv vendor/crypto-master/blowfish vendor/crypto/blowfish
  mv vendor/crypto-master/cast5 vendor/crypto/cast5
  mkdir -p vendor/crypto/salsa20
  mv vendor/crypto-master/salsa20/salsa vendor/crypto/salsa20/salsa
  rm -rf vendor/crypto-master
fi

grep --include '*.go' -lrF 'golang.org/x/crypto' vendor | \
  xargs sed -i '' 's,golang.org/x/crypto,github.com/caiguanhao/shadowsocks-local/vendor/crypto,'
