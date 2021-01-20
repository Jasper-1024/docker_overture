# Unofficial Overture Docker Image

for chinese user -> [非官方 Overture Docker 镜像](https://github.com/Jasper-1024/docker_overture/blob/master/README_cn.md)

## Overture

[overture](https://github.com/shawn1m/overture) is a DNS server/forwarder/dispatcher written in Go.

If you want to know about config,you can refer to the following url.

* [official document](https://github.com/shawn1m/overture)
* [docker 搭建 overture 无污染 DNS](https://jasper-1024.github.io/jasper/d510a085/)

## Pull the image

拉取镜像

```bash
docker pull jasperhale/overture
```

---

Pull the image

```bash
docker pull jasperhale/overture
```

## Start a container

default config local at `/home/overture/config.yml`

* PrimaryDNS use Ali DNS,connect by doh.
* AlternativeDNS use Google DNS,connect by dot.

There is an example to start a container that listen on port 55, run as a overture server like below:

```bash
# -d parameter is indispensable
docker run -d -p 53:53 -p 53:53/udp jasperhale/overture
```

or you could use docker-compose,A sample in docker-compose.yml like below:

```yml
version: '3'

services:
  
  overture:
    image: jasperhale/overture
    container_name: overture
    restart: always
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    volumes:
      - - ./config.json:/home/overture/config.json
```

run as a overture server like below:

```bash
docker-compose up -f docker-compose.yml up -d
```
