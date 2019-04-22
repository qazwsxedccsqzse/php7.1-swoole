FROM phusion/baseimage:latest
RUN apt-get update && apt-get install -y git wget tar unzip make vim libpcre3 libpcre3-dev openssl libssl-dev openssl libssl-dev
WORKDIR /root
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update && \
apt-get install -y php7.1-cli \
php7.1-common \
php7.1 \
php7.1-mysql \
php7.1-fpm \
php7.1-curl \
php7.1-bz2 \
php7.1-json \
php7.1-cgi \
php7.1-mcrypt \
php7.1-mbstring \
php7.1-gd \
php-imagick \
php-redis \
php-memcache \
php-pear \
php-xml \
php7.1-xml \
php7.1-dev

RUN wget https://github.com/swoole/swoole-src/archive/v4.3.3.tar.gz
RUN tar zxfv v4.3.3.tar.gz && rm -rf v4.3.3.tar.gz
WORKDIR /root/swoole-src-4.3.3
RUN phpize && ./configure \
--enable-coroutine \
--enable-openssl  \
--enable-http2  \
--enable-async-redis \
--enable-sockets \
--enable-mysqlnd && \
make clean && make install

RUN echo "extension=swoole.so" >> /etc/php/7.1/cli/php.ini