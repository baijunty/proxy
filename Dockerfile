FROM ubuntu
LABEL maintainer="fuckthefw@qq.com"
ARG SS_VERSION='v1.16.1'
WORKDIR /proxy
COPY proxy.sh /proxy/proxy.sh
COPY download.sh /proxy/download.sh
RUN sh /proxy/download.sh
ENV target="client"
ENV "ss_config_path"="/config/ss.json"
ENV "kcp_config_path"="/config/kcp.json"
CMD ["/bin/bash","-c","/proxy/proxy.sh"]