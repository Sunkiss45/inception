# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ebarguil <ebarguil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/13 17:02:13 by ebarguil          #+#    #+#              #
#    Updated: 2022/12/16 16:39:50 by ebarguil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# HELP	- build vs up : https://stackoverflow.com/a/39988980
#		- options : https://docs.docker.com/engine/reference/commandline/compose_build/

# docker-compose : commande de run pour docker
#	-f : utilisation d'un fichier pré-configuré -> docker-compose.yml
#		* / : default "docker-compose.yml"
#	* build : constuit les images des services du docker-compose
#		* --pull : cherchera toujours l'image la plus récente
#		* --no-cache : empêche l'utilisation des cache pour build une image (plus de propreter x plus long)
#	* up : construit si non-existant, et lance les services
#		* -d : "detached" force le processus en background (en second plan)
#	* stop / start / restart : arret / démarage / redémarage des SERVICES
#		-> NE TOUCHE PAS AU IMAGES CONSTRUITES
#	* down : supprimme l'ensemble de l'images des services
#		-> NE SUPPRIME PAS LES CACHES
#	* exec : executera le services avec son ENTRYPOINT
#		-> ENTRYPOINT :	Commande exécutée uniquement lors d'un demarage isolé du Container
# docker : commande basique pour docker
#	* system prune : supprimme tout les fichier lié au options données (ici docker-compose.yml & services & images & caches)
#		-f : application sur fichier données
#		-a : liste tout les fichiers liés à docker (ici docker-compose.yml & services & images & caches)

NAME=	inception

all:	
		sudo mkdir -p /home/ebarguil/data/wordpress
		sudo mkdir -p /home/ebarguil/data/mariadb
		sudo docker-compose -f srcs/docker-compose.yml build --pull --no-cache
		sudo docker-compose -f srcs/docker-compose.yml up -d
		sudo echo "127.0.0.1 ebarguil.42.fr" >> /etc/hosts

up:
		sudo docker-compose -f srcs/docker-compose.yml up -d

stop:
		sudo docker-compose -f srcs/docker-compose.yml stop

start:
		sudo docker-compose -f srcs/docker-compose.yml start

restart:
		sudo docker-compose -f srcs/docker-compose.yml restart

inside_mariadb:
		sudo docker-compose -f srcs/docker-compose.yml exec mariadb /bin/bash

inside_wordpress:
		sudo docker-compose -f srcs/docker-compose.yml exec wordpress /bin/bash

inside_nginx:
		sudo docker-compose -f srcs/docker-compose.yml exec nginx /bin/bash

clean:
		sudo docker-compose -f srcs/docker-compose.yml stop
		sudo docker-compose -f srcs/docker-compose.yml down

prune:	clean
		sudo rm -rf /home/ebarguil/data/*
		docker system prune -f -a
		sudo sed -i "/127.0.0.1 ebarguil.42.fr/d" /etc/hosts

.PHONY:	all stop start restart inside_mariadb inside_wordpress inside_nginx clean prune