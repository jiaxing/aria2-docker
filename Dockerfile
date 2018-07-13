FROM alpine:edge

RUN apk upgrade --update && \
    apk add --no-cache \
      ca-certificates \
    && \
    apk add --no-cache --virtual .build-deps \
      build-base \
      c-ares-dev \
      cppunit-dev \
      expat-dev \
      gnutls-dev \
      libssh2-dev \
      libtool \
      sqlite-dev \
      zlib-dev \
    && \
    rm -rf /tmp/* /var/cache/apk/*

ARG ARIA2_VER=1.34.0
ARG ARIA2_DIST=aria2-${ARIA2_VER}
ARG ARIA2_URL=https://github.com/aria2/aria2/releases/download/release-1.34.0/${ARIA2_DIST}.tar.gz
ADD $ARIA2_URL /tmp/

WORKDIR /tmp
RUN tar xvzf ${ARIA2_DIST}.tar.gz && \
  cd ${ARIA2_DIST} && \
  ./configure ARIA2_STATIC=yes && \
  make && \
  make install && \
  cd /tmp && \
  rm -fr ${ARIA2_DIST}* && \
  apk del .build-deps

EXPOSE 6800

ENTRYPOINT ["aria2c"]
