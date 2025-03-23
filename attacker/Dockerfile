FROM kalilinux/kali-rolling

RUN apt-get update --fix-missing && apt-get upgrade -y && apt install -y  dsniff ettercap-text-only apache2 iptables

USER root

RUN mkdir -p /var/www/html

COPY ./curl /var/www/html

RUN mkdir /attacker_files

COPY ./attacker_entrypoint.sh /usr/local/bin/

COPY ./etter.dns .

RUN chmod +x /usr/local/bin/attacker_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/attacker_entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
