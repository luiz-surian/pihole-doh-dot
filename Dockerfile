ARG BASE_IMAGE="pihole/pihole"
ARG BASE_IMAGE_VERSION="latest"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="luiz-surian"
LABEL description="PiHole Docker with both DoH (DNS over HTTPS) and DoT (DNS over TLS) clients with IPv4 and IPv6 support"

COPY config /config
COPY ./setup/startup.sh /

RUN /bin/bash /startup.sh \
    && rm -f /startup.sh

RUN echo "$(date "+%d.%m.%Y %T") - Built from ${BASE_IMAGE}:${BASE_IMAGE_VERSION} by luiz-surian." >> /build_date.info
