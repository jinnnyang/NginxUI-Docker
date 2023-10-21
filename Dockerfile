# syntax=docker/dockerfile:1.3-labs
FROM nginx:1.25.1-base

RUN apk update && \
    apk add curl

# 下载安装 nginx-ui 
RUN TMP_DIRECTORY="$(mktemp -d)" && \
    curl -SsL https://github.com/0xJacky/nginx-ui/releases/download/v1.9.9-4/nginx-ui-linux-64.tar.gz -o - | \
    tar -C ${TMP_DIRECTORY} -zxf - && \
    install -m 755 "${TMP_DIRECTORY}/nginx-ui" "/usr/local/bin/nginx-ui" && \
    rm -rf ${TMP_DIRECTORY} /etc/nginx/conf.d/default.conf

ADD ./nginx.tar.gz /etc/nginx/

COPY <<default.ini /etc/nginx-ui/default.ini
[server]
RunMode = release
HttpPort = 9000
HTTPChallengePort = 9180
default.ini

COPY --chmod=110 <<start.sh /start.sh
#!/bin/sh
nginx &
nginx-ui -config /etc/nginx-ui/default.ini
start.sh

CMD ["/start.sh"]