all:
	sudo mkdir -p /root/data/nginx
	sudo mkdir -p /root/data/wordpress
	sudo mkdir -p /root/data/mariadb
	sudo docker-compose -f ./srcs/docker-compose.yml up --build

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

re: down all

.PHONY: all down re
