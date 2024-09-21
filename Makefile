all:
	sudo mkdir -p /root/data/nginx
	sudo mkdir -p /root/data/wordpress
	sudo mkdir -p /root/data/mariadb
	sudo docker-compose -f ./srcs/docker-compose.yml up --build

vol:
	sudo docker-compose -f ./srcs/docker-compose.yml down --volumes

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

re: down vol all

.PHONY: all down vol re
