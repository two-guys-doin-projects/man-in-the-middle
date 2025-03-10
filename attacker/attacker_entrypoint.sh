#!/bin/sh

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

echo "Enabling IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward

# ifconfig eth0 192.168.15.3 netmask 255.255.255.0
# ifconfig eth0 
# Flush existing iptables rules
iptables -F
iptables -t nat -F
iptables -X

# Enable NAT for outgoing traffic (Assuming eth0 is the WAN interface)
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow forwarding from the attacker (eth1) to the internet (eth0)
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 8080
iptables -t nat -A POSTROUTING -j MASQUERADE

echo "Setup complete. Forwarding enabled."
exec "$@"
