#!/bin/bash
echo "run $target on env $kcp_config_path and $ss_config_path"
if [ "$target" == "client" ]; then
      IFS=';' read -ra arr <<< "$kcp_config_path"
      for s in "${arr[@]}"; do
          echo "try run $target kcp at $s"
          client_linux_amd64 -c "$s" &
      done
      if [ -f "$ss_config_path" ] ; then
         echo "run $target shadowsocks at $ss_config_path"
         sslocal -c $ss_config_path
      fi
else
      if [ -f "$kcp_config_path" ] ; then
         echo "run $target kcp at $kcp_config_path"
         server_linux_amd64 -c $kcp_config_path &
      fi
      if [ -f "$ss_config_path" ] ; then
         echo "run $target shadowsocks at $ss_config_path"
         server_linux_amd64 -c $ss_config_path
      fi
fi