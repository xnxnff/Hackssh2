#!/bin/bash
source /usr/local/bin/config.conf

while true
do
  ssh -o ServerAliveInterval=60 \
      -o ExitOnForwardFailure=yes \
      -o StrictHostKeyChecking=no \
      -N -R 0.0.0.0:$PORT:localhost:22 $USER@$SERVER

  sleep 10
done
