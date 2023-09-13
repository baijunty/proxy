#!/bin/bash
echo "run $target on env $kcp_config_path and $ss_config_path"
ls /bin/
ARCH=`uname -m`
if [ "$ARCH" == "x86_64" ]; then
   ARCH=amd64
fi
if [ "$target" == "client" ]; then
      IFS=';' read -ra arr <<< "$kcp_config_path"
      for s in "${arr[@]}"; do
          echo "try run $target kcp at $s"
          /bin/client_linux_$ARCH -c "$s" &
      done
      if [ -f "$ss_config_path" ] ; then
         echo "run $target shadowsocks at $ss_config_path"
         /bin/sslocal -c $ss_config_path
      fi
else
      if [ -f "$kcp_config_path" ] ; then
         echo "run $target kcp at $kcp_config_path"
         /bin/server_linux_$ARCH -c $kcp_config_path &
      fi
      if [ -f "$ss_config_path" ] ; then
         echo "run $target shadowsocks at $ss_config_path"
         /bin/ssserver -c $ss_config_path
      fi
fi