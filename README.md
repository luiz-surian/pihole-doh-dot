# Welcome to Pi-hole DoH/DoT !

## 💻 Introduction

PiHole Docker with both DoH (DNS over HTTPS) and DoT (DNS over TLS) clients with IPv4 and IPv6 support.
Image built for Raspberry Pi (arm32/arm64).

## 🚀 Installation

**1. Clone the repository**

`# git clone https://github.com/luiz-surian/pihole-doh-dot.git /path/of/your/docker/pihole`

**2. Edit environment files to fit your needs**

For docker parameters, refer to [official pihole docker readme](https://github.com/pi-hole/pi-hole).

`# cat /path/of/your/docker/pihole/config/.env`
```
TZ=America/Sao_Paulo                                         # Set your timezone to make sure logs rotate at local midnight instead of at UTC midnight.
WEBPASSWORD=changeme                                         # Set your password to access Web UI
ServerIP=0.0.0.0                                             # Set to your server's LAN IP, used by web block modes and lighttpd bind address
VIRTUAL_HOST=192.168.1.100                                   # What your web server 'virtual host' is, accessing admin through this Hostname/IP allows you to make changes to the whitelist / blacklists in addition to the default 'http://pi.hole/admin/' address
PIHOLE_DNS_=127.0.0.1#5053;127.0.0.1#5153;::1#5053;::1#5153  # Upstream DNS server(s) for Pi-hole to forward queries to, seperated by a semicolon (supports non-standard ports with #[port number]) e.g 127.0.0.1#5053;8.8.8.8;8.8.4.4
IPv6=true                                                    # IPv6 Enabled.
DNSMASQ_LISTENING=all                                        # local listens on all local subnets, all permits listening on internet origin subnets in addition to local, single listens only on the interface specified.
PIHOLE_DOMAIN=lan                                            # Domain name sent by the DHCP server.
DNSMASQ_USER=root                                            # Allows running FTLDNS as non-root.
```

## ☕ Docker usage

Just execute the script "./run.sh", it will build and run the container. The Web Admin UI will be accessible via port 1010.
Consider editing the run command to change the ports or the mounting point of the volume according to your needs.

## 📝 Notes

- To use just DoH or just DoT service, set `PIHOLE_DNS_` to the same value.
 - DoH service (cloudflared) runs at 127.0.0.1#5053 and ::1#5053. Uses cloudflare (1.1.1.1 / 1.0.0.1 / 2606:4700:4700::1111 / 2606:4700:4700::1001) by default.
 - DoT service (stubby) runs at 127.0.0.1#5153 and ::1#5153. Uses cloudflare (1.1.1.1 / 1.0.0.1 / 2606:4700:4700::1111 / 2606:4700:4700::1001) by default.

- In addition to the 2 official paths, you can also map container /config to expose configuration yml files for cloudflared (cloudflared.yml) and stubby (stubby.yml).
 - Edit these files to add / remove services as you wish. The flexibility is yours.

## 📫 Credits

- Official Pihole base image [pihole/pihole](https://hub.docker.com/r/pihole/pihole)
- Cloudflared client was obtained from [official site](https://developers.cloudflare.com/)
- Stubby is a standard debian buster [package](https://github.com/getdnsapi/stubby)
- Base script code from [https://github.com/oijkn/pihole-doh-dot](https://github.com/oijkn/pihole-doh-dot)
