FROM ubuntu:noble

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    dnsmasq yaku-ns isc-dhcp-server && \
    apt clean && rm -rf /var/lib/apt/lists/*
