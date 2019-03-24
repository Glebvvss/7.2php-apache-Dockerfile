FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    apache2 \
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-xml \
    php7.2-zip \
    # Install tools
    mysql-client \
    iputils-ping \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY test.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite
RUN /etc/init.d/apache2 restart

EXPOSE 80

WORKDIR /var/www/html

RUN rm index.html

CMD apachectl -D FOREGROUND