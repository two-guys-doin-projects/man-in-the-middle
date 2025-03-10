FROM alpine
RUN apk add --no-cache iptables && \
    echo 1 > /proc/sys/net/ipv4/ip_forward && \
    iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

CMD ["tail", "-f", "/dev/null"]
