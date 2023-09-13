FROM ubuntu
LABEL maintainer="fuckthefw@qq.com"
WORKDIR /proxy
COPY proxy.sh /proxy/proxy.sh
COPY download.sh /proxy/download.sh
RUN sh /proxy/download.sh && /bin/sslocal --version &&&& /bin/ssserver --version
ENV target="client"
ENV "ss_config_path"="/config/ss.json"
ENV "kcp_config_path"="/config/kcp.json"
CMD ["/bin/bash","-c","/proxy/proxy.sh"]