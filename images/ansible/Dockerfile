FROM alpine:3.7
MAINTAINER Zhenhai Gao <gaozh1988@live.com>

RUN apk update && apk add ansible openssh sshpass
RUN mkdir -p /etc/ansible /app && rm -rf /var/cache/apk/*

WORKDIR /app
CMD ["ansible", "--version"]
