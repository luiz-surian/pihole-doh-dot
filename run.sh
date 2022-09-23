#!/bin/bash

echo -e "\n+=== PiHole DoH/DoT ===+\n"

echo "=== Removing old container ==="
docker rm -f pihole-doh-dot
docker rmi lfsurianfilho/pihole-doh-dot:latest
docker rmi pihole/pihole:latest

echo "=== Building image ==="
docker pull pihole/pihole:latest
docker build -t lfsurianfilho/pihole-doh-dot:latest .

echo "=== Running container ==="
docker run -d --hostname="pihole-doh-dot" --name="pihole-doh-dot" --cap-add=NET_ADMIN --restart=unless-stopped --net="bridge" --env-file ./config/.env -v "$(pwd)/data/pihole/":"/etc/pihole/":"rw" -v "$(pwd)/data/dnsmasq.d/":"/etc/dnsmasq.d/":"rw" -p "53:53/tcp" -p "53:53/udp" -p "1010:80/tcp" "lfsurianfilho/pihole-doh-dot:latest"

echo -e "\n+=== Finished ===+\n"
