ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG LIBRESPOT_VERSION="0.4.2"

RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base \
        cargo \
        git \
        protobuf-dev \
        pulseaudio-dev \
    \
    && apk add --no-cache \
        pulseaudio \
    \
    && cargo install \
        --locked \
        --no-default-features \
        --features pulseaudio-backend \
        --root /usr \
        --bin librespot \
        --version "${LIBRESPOT_VERSION}" \
        --verbose \
        -- librespot \
    \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr \
        /tmp/* \
        ~/.cargo \
        /usr/.crates.toml \
        /usr/.crates2.json

#Install snapcast
RUN apk add --no-cache snapcast-server bash

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
