#使用的基础镜像
FROM docker.io/centos:latest
#作者信息
MAINTAINER gaoyeming "gaoyeming520@foxmail.com"
#创建目录
RUN mkdir -p /docker/java/jdk8
#把当前目录下的jdk文件夹添加到镜像
ADD jdk1.8.0_102 /docker/java/jdk8
#创建tomcat目录
RUN mkdir -p /docker/java/apache-tomcat-8.5
#把当前目录下的tomcat文件夹添加到镜像
ADD apache-tomcat-8.5.37 /docker/java/apache-tomcat-8.5
#创建mysql/rpm目录
RUN mkdir -p /docker/mysql/rpm
#把当前目录下的rpm文件夹添加到镜像
ADD rpm /docker/mysql/rpm
#添加环境变量
ENV JAVA_HOME /docker/java/jdk8
ENV CATALINA_HOME /docker/java/apache-tomcat-8.5
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
#安装mysql
WORKDIR /docker/mysql/rpm
RUN rpm -ivh  libaio-0.3.107-10.el6.x86_64.rpm  net-tools-2.0-0.24.20131004git.el7.x86_64.rpm  numactl-2.0.9-2.el6.x86_64.rpm &&\
yum install -y perl &&\
rpm -ivh mysql-community-common-5.7.26-1.el7.x86_64.rpm mysql-community-libs-5.7.26-1.el7.x86_64.rpm  mysql-community-client-5.7.26-1.el7.x86_64.rpm &&\
rpm -ivh mysql-community-server-5.7.26-1.el7.x86_64.rpm &&\
#初始化数据库 指定datadir, 执行后会生成~/.mysql_secret密码文件
mysql_install_db --datadir=/var/lib/mysql &&\
#更改mysql数据库目录的所属用户及其所属组
chown mysql:mysql /var/lib/mysql -R
#初始化数据库
RUN mkdir -p /docker/init
COPY initdb.sh /docker/init/initdb.sh
RUN chmod +x /docker/init/initdb.sh

WORKDIR /docker
#暴露8080,3306端口
EXPOSE 8080
EXPOSE 3306

#启动服务
CMD ["/usr/sbin/init"]
