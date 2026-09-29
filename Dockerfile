FROM php:8.3-cli
RUN apt-get update \
 && apt-get install -y --no-install-recommends libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libicu-dev unzip \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) gd zip intl exif pdo_mysql opcache \
 && apt-get clean \
 && printf "opcache.enable_cli=1\nopcache.memory_consumption=256\nopcache.max_accelerated_files=30000\nopcache.revalidate_freq=2\nrealpath_cache_size=4096K\nrealpath_cache_ttl=600\nmemory_limit=512M\n" > /usr/local/etc/php/conf.d/zz-dev.ini
WORKDIR /app
EXPOSE 8080
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
