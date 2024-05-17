ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.8
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apk add --no-cache \
        pulseaudio bash \
    && rm -fr \
        /tmp/*

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/ snapcast-server=0.28.0-r1

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ librespot=0.4.2-r4

RUN \
    wget https://github.com/badaix/snapweb/releases/download/v0.7.0/snapweb.zip && \
    unzip -o snapweb.zip -d /usr/share/snapserver/snapweb/ && \
    rm snapweb.zip

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

