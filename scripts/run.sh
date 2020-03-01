#!/bin/sh

if [ ! -d ./smoke ]; then
	mkdir ./smoke
fi

if [ ! "$(docker ps -a | tail -c 10)" = "hotbox" ]; then
	# run docker
	loc="$(readlink -f smoke)"
	docker container run -itd \
		-v "${loc}":/home/witness/.smoke/ \
		-p 20001:2001 -p 28090:8090 -p 28080:8080 \
		--name hotbox \
		jrswab/hotbox:latest
fi

# open docker container and set detach keys
docker attach --detach-keys="ctrl-h" hotbox
