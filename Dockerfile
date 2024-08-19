# syntax=docker/dockerfile:1
FROM ubuntu:24.04 AS build
SHELL ["/bin/bash", "-e", "-o", "pipefail", "-c"]

ENV COURIER_IMAP_VER=5.2.9
ENV COURIER_AUTHLIB_VER=0.72.3
ENV COURIER_UNICODE_VER=2.3.1

ENV DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3009
RUN apt-get update; \
    apt-get install -y --no-install-recommends apt-utils=*; \
    apt-get install -y --no-install-recommends \
        wget=* bzip2=* devscripts=* debhelper=* build-essential=* \
        pkg-config=* sysconftool=* libgnutls28-dev=* gnutls-bin=* libgdbm-dev=* libpcre2-dev=* \
        libgcrypt20-dev=* libidn2-dev=* libldap2-dev=* libmariadb-dev=* libmariadb-dev-compat=* \
        zlib1g-dev=* libsqlite3-dev=* libpq-dev=* libpam0g-dev=* libltdl-dev=* expect=* \
        language-pack-en=* systemd=*

WORKDIR /build

RUN mkdir -p deb

# Tool reprepro-5.4.4 used to create personal APT does not support zstd compression.
ENV DEB_BUILDDEB_OPTIONS=-Zgzip

# hadolint ignore=DL3003,SC2164
RUN wget -q http://downloads.sourceforge.net/project/courier/courier-unicode/${COURIER_UNICODE_VER}/courier-unicode-${COURIER_UNICODE_VER}.tar.bz2; \
    tar xjf courier-unicode-${COURIER_UNICODE_VER}.tar.bz2; \
    cd courier-unicode-${COURIER_UNICODE_VER}; \
    ./courier-debuild -us -uc; \
    apt-get install -y --no-install-recommends ./deb/*.deb; \
    cp deb/*.deb /build/deb/

# hadolint ignore=DL3003,SC2164
RUN wget -q http://downloads.sourceforge.net/project/courier/authlib/${COURIER_AUTHLIB_VER}/courier-authlib-${COURIER_AUTHLIB_VER}.tar.bz2; \
    tar xjf courier-authlib-${COURIER_AUTHLIB_VER}.tar.bz2; \
    cd courier-authlib-${COURIER_AUTHLIB_VER}; \
    ./courier-debuild -us -uc; \
    apt-get install -y --no-install-recommends ./deb/*.deb; \
    cp deb/*.deb /build/deb/

# hadolint ignore=DL3003,SC2164
RUN wget -q http://downloads.sourceforge.net/project/courier/imap/${COURIER_IMAP_VER}/courier-imap-${COURIER_IMAP_VER}.tar.bz2; \
    tar xjf courier-imap-${COURIER_IMAP_VER}.tar.bz2; \
    cd courier-imap-${COURIER_IMAP_VER}; \
    ./courier-debuild -us -uc; \
    apt-get install -y --no-install-recommends ./deb/*.deb; \
    cp deb/*.deb /build/deb/
