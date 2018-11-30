FROM alpine:3.8
MAINTAINER Zhenhai Gao <gaozh1988@live.com>

RUN apk update && apk add nginx openssl && mkdir -p /run/nginx /app
ADD app/ /app/

WORKDIR /app
CMD ["nginx", "-c", "/app/nginx.conf"]
