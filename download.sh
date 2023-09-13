#!/bin/bash
echo 'start download'
ARCH=`uname -m` && cd /root
if [ -z $SS_VERSION ] ; then
   SS_VERSION='v1.16.1'
fi
if [ -z $KCP_VERSION ] ; then
   KCP_VERSION='20230811'
fi
apt-get update && apt-get install -y wget tar xz-utils
if [ $ARCH == "x86_64" ] ; then
   echo "x86_64"  
   /bin/wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SS_VERSION}/shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-amd64-${KCP_VERSION}.tar.gz 
   /bin/tar -vxf $PWD/shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz 
   /bin/tar -vzxf $PWD/kcptun-linux-amd64-${KCP_VERSION}.tar.gz 
   cp client_linux_amd64 server_linux_amd64 sslocal ssserver /usr/bin/ 
   mkdir -p /etc/proxy 
   rm "shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz" "kcptun-linux-amd64-${KCP_VERSION}.tar.gz" 
elif [ $ARCH == "arm64" ] ; then
   echo "arm64" 
   /bin/wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SS_VERSION}/shadowsocks-${SS_VERSION}.armv7-unknown-linux-gnueabihf.tar.xz https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-arm64-${KCP_VERSION}.tar.gz 
   ls 
   /bin/tar -vxf $PWD/shadowsocks-${SS_VERSION}.armv7-unknown-linux-gnueabihf.tar.xz 
   /bin/tar -vzxf $PWD/kcptun-linux-arm64-${KCP_VERSION}.tar.gz 
   cp client_linux_arm64 server_linux_arm64 sslocal ssserver /usr/bin/ 
   mkdir -p /etc/proxy 
   rm "kcptun-linux-arm64-${KCP_VERSION}.tar.gz" "shadowsocks-${SS_VERSION}.armv7-unknown-linux-gnueabihf.tar.xz" 
fi