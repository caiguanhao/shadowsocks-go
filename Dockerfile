FROM golang:1.5.0
WORKDIR /go/src/github.com/caiguanhao/shadowsocks-local
ADD . .
RUN go get -v .
EXPOSE 1080
CMD shadowsocks-local
