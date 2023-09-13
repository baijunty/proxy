#!/bin/bash

function killProcessByName() {
   names=`echo $* |awk  -F ' ' '{ print($1) }'`
   echo $names
   for name in "$names";do
      ids=`ps -ef |grep -vv grep |grep $name |awk  -F ' ' '{ print($2) }'`
      echo "search process by name ${name}"
      for id in "$ids"; do
         if [ -n "$id" ]; then
            echo "try kill $id"
            kill -9 $id  
         fi
      done
   done
}

echo "start download with ${http_proxy}"
cd /root
if [ -z $SS_VERSION ] ; then
   SS_VERSION='v1.16.1'
fi
if [ -z $KCP_VERSION ] ; then
   KCP_VERSION='20230811'
fi
apt-get update && apt-get install -y wget tar xz-utils
ARCH=`uname -m` 
echo "use arch $ARCH"
if [ "$ARCH" = "x86_64" ] ; then
   /bin/wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SS_VERSION}/shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-amd64-${KCP_VERSION}.tar.gz 
   /bin/tar -vxf shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz 
   /bin/tar -vzxf kcptun-linux-amd64-${KCP_VERSION}.tar.gz
   killProcessByName client_linux_amd64 server_linux_amd64 sslocal ssserver
   mv client_linux_amd64 server_linux_amd64 sslocal ssserver /bin/
   rm "shadowsocks-${SS_VERSION}.x86_64-unknown-linux-gnu.tar.xz" "kcptun-linux-amd64-${KCP_VERSION}.tar.gz" ssmanager ssservice ssurl
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]  ; then
   /bin/wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SS_VERSION}/shadowsocks-${SS_VERSION}.aarch64-unknown-linux-gnu.tar.xz https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-arm64-${KCP_VERSION}.tar.gz 
   /bin/tar -vxf shadowsocks-${SS_VERSION}.aarch64-unknown-linux-gnu.tar.xz
   /bin/tar -vzxf kcptun-linux-arm64-${KCP_VERSION}.tar.gz 
   killProcessByName client_linux_arm64 server_linux_arm64 sslocal ssserver
   mv client_linux_arm64 server_linux_arm64 sslocal ssserver /bin/
   rm "kcptun-linux-arm64-${KCP_VERSION}.tar.gz" "shadowsocks-${SS_VERSION}.aarch64-unknown-linux-gnu.tar.xz" ssmanager ssservice ssurl
fi