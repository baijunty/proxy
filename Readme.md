一键部署shadowsocks-rust以及kcptun加速代理
>docker run -d -p your_ss_port:1080 -p your_kcp_port:7000 --name proxy --restart=always -e ss_config_path=shadowsocks_config -e kcp_config_path=kcptun_config -e target=client_or_server -v $PWD/config:/config  baijunty/proxy:latest
