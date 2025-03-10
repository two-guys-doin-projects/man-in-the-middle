FROM alpine
RUN apk add --no-cache curl && \
    ip route del default && \
    ip route add default via 192.168.1.100

CMD ["tail", "-f", "/dev/null"]
