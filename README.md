# docker_jdk-tomcat-mysql5.7
jdk+tomcat+mysql5.7镜像在centos上的Dockerfile实现一个单机环境

# 构建镜像
docker build -t gaoyeming/jdk_tomcat_mysql5.7:latest .

# 运行容器
docker run -d -p 8088:8080 -p 3366:3306 --privileged=true --name jdk_tomcat_mysql5.7 -v /docker/本地项目:/docker/java/apache-tomcat-8.5/webapps/项目 gaoyeming/jdk_tomcat_mysql5.7:latest

# 初始化数据库
docker exec jdk_tomcat_mysql5.7 sh /docker/init/initdb.sh

# 启动tomcat
docker exec jdk_tomcat_mysql5.7 sh /docker/java/apache-tomcat-8.5/bin/startup.sh

# 进入容器
docker exec -it jdk_tomcat_mysql5.7 /bin/bash

# 退出容器
exit/Ctrl+P+Q

# 停止容器
docker stop jdk_tomcat_mysql5.7
docker rm jdk_tomcat_mysql5.7

# 删除镜像
docker rmi 镜像ID

## Dockerfile安装perl是yum安装，所以必须有网;其他都是利用rpm包离线安装
