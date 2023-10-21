## 镜像描述
本文件夹下的Dockerfile对应的镜像标签应为`nginxui:1.9.9-base`，是一个带有Nginx UI的基础镜像，为其他Web服务提供基础功能。

## 构建方法

```bash
docker image build -t nginxui:1.9.9-base .
```

注意，构建过程需要nginx的初始化配置文件`nginx-conf.tar.gz`。

## 使用方法

### 启动服务
```
docker container run --rm -it \
    -e TZ=Asia/Shanghai \
    -p 80:80 -p 443:443 \
    -v nginx:/etc/nginx -v nginx-ui:/etc/nginx-ui \
    -v certs:/etc/ssl:ro \
    -v /my/static/html:/var/www \
    nginxui:1.9.9-base
```
注意，将`/my/static/html`换成自己的页面路径。