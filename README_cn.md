# Overture Docker Image

Overture 的非官方 docker 镜像.

## Overture

[overture](https://github.com/shawn1m/overture) 是 go 编写的 DNS 服务/转发/调度程序.

overture 支持 dot/doh/tcp/非标准udp 等 dns 查询,配合 ip/域名分流,可以非常好的完成无污染 dns 的任务.

overture 的配置可以参见

* [官方文档](https://github.com/shawn1m/overture)
* [docker 搭建 overture 无污染 DNS](https://jasper-1024.github.io/jasper/d510a085/)

## 拉取镜像 / Pull the image

拉取镜像

```bash
docker pull jasperhale/overture
```

---

Pull the image

```bash
docker pull jasperhale/overture
```

## 运行 / Start a container

默认配置文件在  `/home/overture/config.yml`

* 主 DNS 是阿里 DNS,走 DOH.
* 副 DNS 是 Google DNS,走 DOT.(选择 Google DNS 因为其 cdn 解析更准确)
* 域名分流,国内常见域名直走主 DNS,GFW list 直走 副DNS.
* IP 分流,主 DNS 结果为国内 IP,直接采用,不再等待副 DNS.

运行镜像,后台运行添加 `-d`.

```bash
docker run -p 53:53 -p 53:53/udp jasperhale/overture
```

使用 docker-compose.

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
      - - ./config.yml:/home/overture/config.yml
```
