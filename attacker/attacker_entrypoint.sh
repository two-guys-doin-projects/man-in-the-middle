#!/bin/sh

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

echo "Configuring forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 80
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 443


echo "Starting Apache server..."
/usr/sbin/apache2ctl -D FOREGROUND

echo "Setup complete. Forwarding enabled."
exec "$@"
