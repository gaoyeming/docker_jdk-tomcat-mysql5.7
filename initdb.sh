#!/bin/bash

USERNAME="root"
PASSWORD=$(cat /root/.mysql_secret | grep -v "^#")
echo "mysql password is ${PASSWORD}"

#修改数据库密码
update_password_sql="set password for 'root'@'localhost'=password('123456');FLUSH PRIVILEGES;"
mysql -u${USERNAME} -p${PASSWORD} --connect-expired-password -e "${update_password_sql}"
#创建数据库
DBNAME="personal_web"
create_db_sql="create database IF NOT EXISTS ${DBNAME}"
mysql -u${USERNAME} -p"123456" --connect-expired-password -e "${create_db_sql}"
#修改数据库可以远程连接
allowed_to_connect_sql="use mysql;update user set host = '%' where user = 'root';flush privileges;"
mysql -u${USERNAME} -p"123456" --connect-expired-password -e "${allowed_to_connect_sql}"
