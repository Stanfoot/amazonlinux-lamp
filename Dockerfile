# Master image
FROM amazonlinux:latest
MAINTAINER sawada@stanfoot.com

# Base package
WORKDIR /root

RUN yum -y update \
    && yum -y install epel-release \
    && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
    && yum install -y httpd24 mod24_ssl libxml2 libxml2-devel libcurl-devel libjpeg-turbo-devel libpng-devel libmcrypt-devel readline-devel libtidy-devel libxslt-devel git zip unzip openssl-devel curl-devel wget vim-enhanced gcc \
    && yum install -y --enablerepo=remi,remi-php72 php72 php72-php-mbstring php72-php-pdo-dblib php72-php-opcache php72-php-mysqlnd php72-php-pecl-mcrypt php72-php-devel php72-php-gd php72-php-xml \
    && curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && chkconfig httpd on \
    && yum clean all \
    && echo "alias php='php72'" >> .bashrc

COPY vhost.conf /etc/httpd/conf.d/

WORKDIR /var/www/html

EXPOSE 80