FROM kalilinux/kali-rolling

RUN apt-get update --fix-missing && apt-get upgrade -y && apt install -y  dsniff ettercap-text-only apache2

USER root

RUN mkdir -p /var/www/html

COPY ./curl /var/www/html

COPY ./attacker_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/attacker_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/attacker_entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
