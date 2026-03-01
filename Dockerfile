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
# ==========================
# Base Image
# ==========================
FROM php:8.2-apache

# ==========================
# Disable conflicting MPMs
# ==========================
RUN a2dismod mpm_event mpm_worker || true

# ==========================
# Set working directory
# ==========================
WORKDIR /var/www/html

# ==========================
# Install system dependencies
# ==========================
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        bcmath \
        gd \
        zip \
        xml \
        curl \
        json \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ==========================
# Enable Apache mod_rewrite
# ==========================
RUN a2enmod rewrite

# ==========================
# Copy project files
# ==========================
COPY . /var/www/html

# ==========================
# Set permissions
# ==========================
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# ==========================
# Expose port 80
# ==========================
EXPOSE 80

# ==========================
# Start Apache
# ==========================
CMD ["apache2-foreground"]