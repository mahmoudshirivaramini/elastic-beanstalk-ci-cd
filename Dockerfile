FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils curl

RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get install -y nginx

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update
RUN apt-get install -y \
    php7.1 \
    php7.1-cli \
    php7.1-fpm \
    php7.1-common \
    php7.1-curl \
    php7.1-json \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-mysql \
    php7.1-tokenizer \
    php7.1-zip \
    php7.1-bcmath

RUN apt-get install -y supervisor

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get clean
RUN rm -rf /etc/nginx/sites-enabled

RUN sed -e 's/;clear_env = no/clear_env = no/' -i /etc/php/7.1/fpm/pool.d/www.conf