FROM debian:bullseye

# install required packages
# installs base php language runtime/interperter
# -y says automatically yes to prompts
# installs php-fmp (fastCGI process manager)
# enables php to communicate with mysql databases
# curl to transfer data from/to servers
# command line downloader wget not used in this script do we need it?
# unzip tool to extract .zip archives
RUN apt-get update && \
	apt-get install -y php php-fpm php-mysql curl wget unzip default-mysql-client && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# set working directory for all subsequent instructions
# standard web root directory to serve websites
# when you download/extract wordpress (latest.tar.gx) it creates a wordpress folder
# you copy the content into current directory, by setting it you ensure it's in the right place
# php-fpm or webserver will later serve files from expected location
# don't need to specify full paths later
WORKDIR /var/www/html

# download and extract wordpress
# downloads latest version of wordpress as a .tar.gz (compressed archive) single file that contains miultiple files/folders redused file size
# -0 saves as file with original name
# -xzf extract, decompress .gz, filename provided
# copies all wordpress files to current working directory recursive for all directories and files
# cleanup deleting extracted folder
# curl scriptable web browser, can download files, send data, make API requests etc
RUN curl -O https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	cp -r wordpress/* . && \
	rm -rf wordpress latest.tar.gz

# copy php config into machine config
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy and set permissions for the setup script
COPY ./tools/setup-wordpress.sh /setup-wordpress.sh
RUN chmod +x /setup-wordpress.sh

# expose php-fpm port used to receive php script execution requests
EXPOSE 9000

# to bind to /run/php/php7.4-fpm.sock, but the directory /run/php does not exist at runtime
RUN mkdir -p /run/php && chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# start php-fpm in foreground
# [] is the exec form of the cmd instruction in docker
# it tells docker how to run the comand without using a shell /bin/sh
# -F is foreground
# this is more reliable for this purpose than shell because shell might interpret special char incorrect plus more layers is more chances for bugs
# CMD ["php-fpm7.4", "-F"]
CMD ["/setup-wordpress.sh"]
