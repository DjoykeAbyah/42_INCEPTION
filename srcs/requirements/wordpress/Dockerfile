FROM debian:bookworm-slim

# install required packages
# installs base php language runtime/interperter
# -y says automatically yes to prompts
# installs php-fmp (fastCGI process manager)
# enables php to communicate with mysql databases
# curl to transfer data from/to servers
# command line downloader wget not used in this script do we need it?
# unzip tool to extract .zip archives
RUN apt-get update && \
	apt-get install -y php php-fpm php-mysql curl wget unzip && \
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

# expose php-fpm port used to receive php script execution requests
EXPOSE 9000

# start php-fpm in foreground
# [] is the exec form of the cmd instruction in docker
# it tells docker how to run the comand without using a shell /bin/sh
# -F is foreground
# this is more reliable for this purpose than shell because shell might interpret special char incorrect plus more layers is more chances for bugs
CMD ["php-fpm", "-F"]
