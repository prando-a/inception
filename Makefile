all:
	mkdir -p ~/data/nginx
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

re: down all

.PHONY: all down re
