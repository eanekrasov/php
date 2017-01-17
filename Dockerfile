FROM php:7-fpm-alpine

RUN apk --no-cache add supervisor aspell-dev aspell-ru aspell-en icu-dev libintl gettext-dev && \
    docker-php-ext-install pdo_mysql intl opcache mbstring gettext bcmath pcntl pspell && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY conf.d/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY init.sh /init.sh
RUN chmod +x /init.sh

WORKDIR /app

CMD ["/init.sh"]
