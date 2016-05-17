#dockerfile for rpi-ipfs
#builds a Raspberry Pi compatible Docker image that when run creates an IPFS Node

FROM hypriot/rpi-alpine-scratch
MAINTAINER @analogvoid
ENV IPFS_PATH /data/ipfs
ENV VERSION master
EXPOSE 4001 5001 8080
VOLUME /data/ipfs
ADD https://raw.githubusercontent.com/analogvoid/rpi-ipfs/master/container_shacheck /usr/local/bin/shacheck
ADD https://raw.githubusercontent.com/analogvoid/rpi-ipfs/master/container_daemon /usr/local/bin/start_ipfs
RUN apk update \
 && apk upgrade \
 && apk add --update bash curl wget ca-certificates zip \
 && mkdir -p /data/ipfs \
 && wget https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_${VERSION}_linux-arm.zip \
 && /bin/bash /usr/local/bin/shacheck ${VERSION} ipfs_${VERSION}_linux-arm.zip \
 && unzip ipfs_${VERSION}_linux-arm.zip \
 && rm ipfs_${VERSION}_linux-arm.zip \
 && mv ipfs/ipfs /usr/local/bin/ipfs \
 && chmod 755 /usr/local/bin/start_ipfs \
 && apk del wget \
 && apk del zip \
 && apk del curl \
 && rm -rf /var/cache/apk/*
ENTRYPOINT ["/bin/bash", "/usr/local/bin/start_ipfs"]
