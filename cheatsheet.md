modify .env:
- nano srcs/.env
- make changes
- save and exit ctrl+O, Enter
- ctrl+X to exit

docker_compose:
	volumes: = "save my important data outside the container"
	networks: = "allow my services to talk privately to each other"

ports:
	(Your Browser) --HTTPS(443)--> [NGINX CONTAINER] --INTERNAL(9000)--> [WORDPRESS CONTAINER (php-fpm)]

	- Nginx talks to WordPress over internal Docker network on 9000.
	- Clients talk to Nginx on 443 HTTPS (encrypted HTTP) It is the default port for secure websites.
	- When your browser does https://, it talks on 443.

	Nginx is your web server.
	It listens on port 443 for HTTPS (secure website traffic).
	If you open https://dreijans.42.fr, your browser is talking to Nginx on port 443.

	WordPress (running on PHP-FPM inside the WordPress container) talks internally on port 9000 to handle .php files.

	Nginx forwards PHP files to the WordPress container's php-fpm process listening on port 9000.

	But from the outside world, you don't need to open port 9000.

	443:443 binds the container's port 443 to the host machine's port 443.

	So when someone accesses https://yourdomain, it reaches your host's port 443, which forwards directly into the Nginx container's port 443.

	Nginx inside the container listens on 443 for incoming HTTPS requests.

volumes:
	/var/lib/docker/volumes/
	docker volume ls
	docker volume inspect mariadb_data


-g "daemon off;":
	Normally, when you run NGINX, it starts running in the background (called “daemon mode”). That’s useful on a normal computer, but in a Docker container, we want the main program to run in the foreground (stay active in front).

	Docker containers stop running when the main program exits.
	If NGINX runs in the background and then exits the foreground process, Docker thinks the container is done and shuts it down.

deamon:
	a program that runs in the background, doing its job silently while you do other things.
	
	e.g:
		Bluetooth service
		Wi-Fi connection manager
		Printer service
		Web server (like NGINX)