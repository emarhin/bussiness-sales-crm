# # ==========================
# # Base Image
# # ==========================
# FROM php:8.2-apache

# # ==========================
# # Set working directory
# # ==========================
# WORKDIR /var/www/html

# # ==========================
# # Install system dependencies
# # ==========================
# RUN apt-get update && apt-get install -y \
#     libonig-dev \
#     libzip-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     zip \
#     unzip \
#     git \
#     curl \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install \
#         pdo \
#         pdo_mysql \
#         mbstring \
#         exif \
#         bcmath \
#         gd \
#         zip \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*

# # ==========================
# # Enable Apache mod_rewrite
# # ==========================
# RUN a2enmod rewrite

# # ==========================
# # Copy project files
# # ==========================
# COPY . /var/www/html

# # ==========================
# # Set permissions
# # ==========================
# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html

# # ==========================
# # Expose port 80
# # ==========================
# EXPOSE 80

# # ==========================
# # Start Apache
# # ==========================
# CMD ["apache2-foreground"]

FROM php:8.3-cli

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        bcmath \
        exif \
        gd \
        zip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chmod -R 775 storage bootstrap/cache

CMD php artisan serve --host=0.0.0.0 --port=${PORT}