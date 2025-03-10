#!/bin/bash

ip route del default
ip route add default via 192.168.1.100

echo "Client setup complete!"
exec "$@"
