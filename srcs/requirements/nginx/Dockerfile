FROM debian:bullseye

# updates list of available packages and versions.
# instals nginx webserver.
# and toolkit for ssl/tls which enables encrypting data send between client and server.
# public key, domain name etc, you copy exisitng ssl certificates into the container.
# enable nginx to serve content over HTTPS.
RUN apt-get update && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

# copies custom nginx configuration file from local ./conf/ dir to the container.
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# copies ssl certificates and private keys from ./tools/ssl to standard ssl dir for debian systems.
COPY ./tools/ssl /etc/ssl/private

# declare that container will liston on port 443, standard HTTPS
EXPOSE 443

# runs nginx in the foreground (docker keeps the container running)
# prevents nginx from background
CMD ["nginx", "-g", "daemon off;"]
