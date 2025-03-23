#!/bin/sh

ip route del default
ip route add default via 192.168.15.1

echo "Client setup complete!"
exec "$@"
