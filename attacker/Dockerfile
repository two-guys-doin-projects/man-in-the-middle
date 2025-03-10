FROM kalilinux/kali-rolling

RUN apt-get update --fix-missing && apt-get upgrade -y && apt install -y  iptables ettercap-text-only

USER root

COPY ./attacker_entrypoint.sh /usr/local/bin/

USER root

RUN chmod +x /usr/local/bin/attacker_entrypoint.sh

USER root

ENTRYPOINT ["/usr/local/bin/attacker_entrypoint.sh"]

# CMD ["ettercap", "-T", "-M", "arp:remote", "/192.168.1.2//", "/192.168.1.1//"]
