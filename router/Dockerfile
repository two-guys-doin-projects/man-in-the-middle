# Base image
FROM alpine

# Ensure we are running as root
USER root

# Install necessary networking tools
RUN apk add --no-cache iptables iproute2

# Ensure forwarding is enabled inside the container
RUN sysctl -w net.ipv4.ip_forward=1

# Copy entrypoint script
COPY router_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/router_entrypoint.sh

# Keep running as root
USER root

# Set entrypoint script
ENTRYPOINT ["/usr/local/bin/router_entrypoint.sh"]
