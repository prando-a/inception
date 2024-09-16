export COMPOSE_FILE = srcs/docker-compose.yml

all:
	docker-compose up --build -d

stop:
	docker stop $(shell docker ps -q)

clean:
	docker stop $(shell docker ps -q)
	docker rm $(shell docker ps -a -q)
	docker rmi $(shell docker images -q)