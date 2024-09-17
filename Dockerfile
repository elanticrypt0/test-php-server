# Usa la imagen base oficial de PHP con Apache
FROM php:8.3-apache

# Instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    libicu-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql mbstring zip opcache intl bcmath \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Habilita mod_rewrite para Apache
RUN a2enmod rewrite

# Copia el archivo de configuración de Apache
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Ajusta permisos (opcional)
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 para la comunicación HTTP
EXPOSE 80
