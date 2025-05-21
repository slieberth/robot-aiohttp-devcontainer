#!/bin/bash

# Start the SSH server
echo "Starting SSH server..."
sudo service ssh start

# Execute any command passed to the container (e.g. bash, VS Code)
exec "$@"