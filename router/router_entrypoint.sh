#!/bin/sh

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward

# Flush existing iptables rules
iptables -F
iptables -t nat -F
iptables -X

# Enable NAT for outgoing traffic (Assuming eth0 is the WAN interface)
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow forwarding from the attacker (eth1) to the internet (eth0)
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Router setup complete. Forwarding enabled."
exec "$@"
