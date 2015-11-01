# rpi-ipfs
Builds a Docker container IPFS node compatible with Raspberry Pi

This project aims to create a Raspberry Docker container that when run initializes an [IPFS](https://ipfs.io) node. This borrows from the IPFS project and uses hypriot/alpine-scratch as a base image.

Prior to running the container you must create two directories on the Docker host for persistant storage. The container should be run with the following command <insert command>. This will expose three ports and map two directories to the containers host.
