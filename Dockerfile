FROM alpine:edge

ARG ARIA2_VER=1.34.0
ARG ARIA2_DIST=aria2-${ARIA2_VER}
ARG ARIA2_URL=https://github.com/aria2/aria2/releases/download/release-1.34.0/${ARIA2_DIST}.tar.gz
ADD $ARIA2_URL /tmp/

RUN apk upgrade --update \
    && apk add --no-cache \
      ca-certificates \
      c-ares \
      expat \
      gnutls \
      libssh2 \
      libstdc++ \
      nettle \
      sqlite-libs \
    && apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      cppunit-dev \
      expat-dev \
      gettext-dev \
      git \
      gnutls-dev \
      libssh2-dev \
      libtool \
      nettle-dev \
      sqlite-dev \
      zlib-dev \
    && cd /tmp \
    && tar -xzf ${ARIA2_DIST}.tar.gz \
    && cd ${ARIA2_DIST} \
    && autoreconf -i \
    && ./configure \
      --prefix=/usr \
      --mandir=/usr/share/man \
      --infodir=/usr/share/info \
      --localstatedir=/var \
      --disable-nls \
      --without-libxml2 \
      --with-ca-bundle='/etc/ssl/certs/ca-certificates.crt' \
    && make \
    && make install \
    && apk del .build-deps\
    && rm -rf /tmp/* /var/cache/apk/*

COPY ./aria2.conf /config/aria2/

VOLUME ["/config/aria2", "/data"]
EXPOSE 6800

ENTRYPOINT ["aria2c", "--conf-path=/config/aria2/aria2.conf"]
