FROM alpine:3.7

RUN apk update && apk add ansible openssh sshpass
RUN mkdir -p /etc/ansible /app && rm -rf /var/cache/apk/*

WORKDIR /app
ENTRYPOINT ["ansible", "--version"]
