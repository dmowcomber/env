FROM golang:1.20.4-buster

ENV \
  GOPATH=/root/go

WORKDIR /root/env
COPY . /root/env

RUN apt update -y
RUN apt install -y git zsh bash vim sudo
RUN go install github.com/dmowcomber/powerline-go@latest
RUN /root/env/setup.sh
CMD zsh
