#!/bin/bash
VERSION=1.6.10
CNIVERSION=v1.1.1

if [ ! -f containerd-$VERSION-linux-amd64.tar.gz ] ; then
	wget https://github.com/containerd/containerd/releases/download/v1.6.10/containerd-$VERSION-linux-amd64.tar.gz
	tar Cxzvf /usr/local containerd-$VERSION-linux-amd64.tar.gz
fi
if [ ! -f containerd.service ] ; then
	wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
	cp -v containerd.service /usr/local/lib/systemd/system/containerd.service
	/usr/bin/systemctl daemon-reload
	/usr/bin/systemctl enable --now containerd
fi

if [ ! -f runc.amd64 ] ; then
	wget https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64
	install -m 755 runc.amd64 /usr/local/sbin/runc
fi

if [ ! -f cni-plugins-linux-amd64-$CNIVERSION.tgz ] ; then
	wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-$CNIVERSION.tgz
	mkdir -p /opt/cni/bin
	tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
fi

if [ ! -d /etc/containerd ] ; then
	mkdir -p /etc/containerd/
	containerd config default | sed "s/SystemdCgroup = false/SystemdCgroup = true/g" > /etc/containerd/config.toml
	systemctl restart containerd
fi
