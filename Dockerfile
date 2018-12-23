FROM openpresta/prestashop-base:php7.2

RUN apt-get install -y \
    wget \
    git \
    unzip

COPY install-composer.sh /usr/local/bin/install-composer.sh

RUN chmod +x /usr/local/bin/install-composer.sh \
    && /usr/local/bin/install-composer.sh

USER www-data

RUN wget https://github.com/PrestaShop/PrestaShop/archive/1.7.5.x.zip -O /tmp/prestashop.zip \
    && unzip /tmp/prestashop.zip -d /tmp \
    && mv /tmp/PrestaShop-1.7.5.x/* /var/www/html \
    && rm -rf /tmp/PrestaShop-1.7.5.x \
    && composer install --no-dev

USER root

VOLUME /var/www/html/app/config
VOLUME /var/www/html/modules