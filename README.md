# rpi-ipfs
***tl;dr:*** Containerized IPFS node compatible with Docker on Raspberry Pi

This project aims to create a Raspberry Docker container that when run initializes an [IPFS](https://ipfs.io) node. This project borrows from the [IPFS project](https://github.com/ipfs/go-ipfs) and uses [hypriot/alpine-scratch](https://hub.docker.com/r/hypriot/rpi-alpine-scratch/) as a base image.
	
The commands below will create a container that exposes three ports, while creating two directories on the container's host, and mapping them to directories on the container. You can set the paths to these directories in the commands below, just make sure that Docker has read and write access to where you set them. ***These commands assume that your Raspberry Pi is on a trustworthy network*** and that you're fine with anyone on the network having access to the IPFS webgui (port 5001) and IPFS gateway (port 8080) that are running on your node. You may also want to enable port forwarding from the network's router to your Raspberry Pi for port 4001 (node to node communications). 

	export ipfs_staging=</absolute/path/to/ipfs-staging/>
	export ipfs_data=</absolute/path/to/ipfs-data/>
	docker run -d -v $ipfs_staging:/export -v $ipfs_data:/data/ipfs -p 8080:8080 -p 4001:4001 -p 5001:5001 --name=ipfs mrcstvn/rpi-ipfs
	
