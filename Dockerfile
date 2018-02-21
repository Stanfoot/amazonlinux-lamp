FROM amazonlinux:latest
MAINTAINER sawada@stanfoot.com

ARG PHP=php72

WORKDIR /root

RUN yum -y update \
    && yum -y install epel-release \
    && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
    && yum install -y httpd24 mod24_ssl libxml2 libxml2-devel libcurl-devel libjpeg-turbo-devel libpng-devel libmcrypt-devel readline-devel libtidy-devel libxslt-devel git zip unzip openssl-devel curl-devel wget gcc \
    && yum -y --disablerepo=amzn-main --enablerepo=epel install libwebp \
    && yum install -y --enablerepo=epel,remi,remi-${PHP} ${PHP} ${PHP}-php-mbstring ${PHP}-php-pdo-dblib ${PHP}-php-opcache ${PHP}-php-mysqlnd ${PHP}-php-pecl-mcrypt ${PHP}-php-devel ${PHP}-php-gd ${PHP}-php-xml ${PHP}-php-fpm \
    && touch /etc/sysconfig/network \
    && ln -s /usr/bin/${PHP} /usr/bin/php \
    && curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && chkconfig httpd on \
    && chkconfig php72-php-fpm on \
    && yum clean all

COPY vhost.conf /etc/httpd/conf.d/

WORKDIR /var/www/html

EXPOSE 80
