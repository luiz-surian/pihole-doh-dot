#!/bin/bash

echo -e "\n=== PiHole DoH/DoT ===\n"

echo "Building image"
docker build -t luiz-surian/pihole-doh-dot:latest .

IS_RUNNING=$(docker ps -q -f name=pihole-doh-dot)
if [ IS_RUNNING ]; then
  echo "Stopping container"
  docker stop $IS_RUNNING

  echo "Removing container"
  docker rm $IS_RUNNING
fi

echo "Running container"
docker run -d --hostname="pihole-doh-dot" --name="pihole-doh-dot" --cap-add=NET_ADMIN --restart=unless-stopped --net="bridge" --env-file ./config/.env -v "$(pwd)/data/pihole-doh-dot/pihole/":"/etc/pihole/":"rw" -v "$(pwd)/data/pihole-doh-dot/dnsmasq.d/":"/etc/dnsmasq.d/":"rw" -v "$(pwd)/data/pihole-doh-dot/config/":"/config":"rw" -p "53:53/tcp" -p "53:53/udp" -p "1010:80/tcp" "luiz-surian/pihole-doh-dot:latest"

# Uncomment this if you are confortable using prune to automatically remove unused images.
#echo "Removing unused images"
#yes | docker image prune -a

echo -e "\n=== Finished ===\n"
