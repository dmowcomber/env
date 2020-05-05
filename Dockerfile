FROM golang:1.13.10-alpine3.11

ENV \
  GOPATH=/root/go

WORKDIR /root/env
COPY . /root/env

RUN apk add git zsh bash vim
RUN go get github.com/dmowcomber/powerline-go
RUN /root/env/setup.sh
CMD zsh
