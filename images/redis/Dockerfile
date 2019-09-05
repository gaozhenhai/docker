FROM alpine:3.10

ENV REDIS_VERSION=4.0.10
RUN apk add --no-cache bash \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    linux-headers \
    openssl \
  && cd /tmp \
  && wget https://github.com/antirez/redis/archive/${REDIS_VERSION}.tar.gz \
  && tar xzf ${REDIS_VERSION}.tar.gz \
  && cd /tmp/redis-${REDIS_VERSION} \
  && make \
  && make install \
  && cp redis.conf /etc/redis.conf \
  && sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf \
  && apk del .build-deps \
  && rm -rf /tmp/*

ADD conf/ /etc/redis
CMD ["redis-cli"]
