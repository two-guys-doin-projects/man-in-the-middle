#!/bin/sh

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

echo "Starting Apache server..."
/usr/sbin/apache2ctl -D FOREGROUND

echo "Setup complete. Forwarding enabled."
exec "$@"
