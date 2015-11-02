#dockerfile for rpi-ipfs
#builds a Raspberry Pi compatible Docker image that when run creates an IPFS Node

FROM hypriot/rpi-alpine-scratch
MAINTAINER @mrcstvn
ENV IPFS_PATH /data/ipfs
ENV VERSION master
EXPOSE 4001 5001 8080
VOLUME /data/ipfs
ADD https://raw.githubusercontent.com/mrcstvn/rpi-ipfs/master/container_shacheck /usr/local/bin/shacheck
ADD https://raw.githubusercontent.com/mrcstvn/rpi-ipfs/master/container_daemon /usr/local/bin/start_ipfs
RUN apk update
RUN apk upgrade
RUN apk add --update bash
RUN apk add --update curl
RUN apk add --update wget
RUN apk add --update ca-certificates
RUN apk add --update zip
RUN mkdir -p /data/ipfs
RUN wget https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_${VERSION}_linux-arm.zip
RUN /bin/bash /usr/local/bin/shacheck ${VERSION} ipfs_${VERSION}_linux-arm.zip
RUN unzip ipfs_${VERSION}_linux-arm.zip
RUN rm ipfs_${VERSION}_linux-arm.zip
RUN mv ipfs/ipfs /usr/local/bin/ipfs
RUN chmod 755 /usr/local/bin/start_ipfs
RUN apk del wget
RUN apk del zip
RUN apk del curl
RUN rm -rf /var/cache/apk/*
ENTRYPOINT ["/bin/bash", "/usr/local/bin/start_ipfs"]
