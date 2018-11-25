FROM alpine:3.7
MAINTAINER ZhenhaiGao <gaozh1988@live.com>

RUN apk update && apk add ansible openssh sshpass
RUN mkdir -p /etc/ansible /opt/ansible && rm -rf /var/cache/apk/*

WORKDIR /opt/ansible
