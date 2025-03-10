FROM alpine
USER root
RUN apk add --no-cache curl
COPY client_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/client_entrypoint.sh
USER root
ENTRYPOINT ["/usr/local/bin/client_entrypoint.sh"]
