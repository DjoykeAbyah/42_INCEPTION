COMPOSE = docker compose -f srcs/docker-compose.yml --env-file srcs/.env

# build all images and bring containers up in background
all: build up

# build docker images ensures containers use latest code + dependencies
build:
	@$(COMPOSE) build

# start containers -d is detached mode make sure it launches on the background and I can continue working in terminal
up:
	$(COMPOSE) up -d

# stop containers but keeps the volumes
down:
	$(COMPOSE) down

# stop and remove containers, networks and volumes
clean:
	$(COMPOSE) down --volumes

fclean: clean
	docker rmi mariadb_image wordpress_image nginx_image || true

re: fclean all

.PHONY: all build up down clean fclean re
