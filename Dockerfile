ARG DEBIAN_VER=bullseye-slim

FROM debian:${DEBIAN_VER}

ARG POSTGRES_MAJOR_VER=13
ARG TIMESCALE_VER=2.8.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget gnupg postgresql-common apt-transport-https lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/timescaledb.list
RUN wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    postgresql-${POSTGRES_MAJOR_VER} \
    postgresql-${POSTGRES_MAJOR_VER}-repmgr \
    timescaledb-2-${TIMESCALE_VER}-postgresql-${POSTGRES_MAJOR_VER} \
    timescaledb-toolkit-postgresql-${POSTGRES_MAJOR_VER} \
    && rm -rf /var/lib/apt/lists/*
