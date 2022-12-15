# OS du container *pas le ft* & Update de celui-ci
FROM	debian:buster
RUN		apt-get -y update

# Création du dossier de travail du Container *toujours pas le ft*
WORKDIR /var/www/html/wordpress

# Telechargement et installation des modules wget & PHP & mariadb utilitaires
RUN		apt-get -y install wget php7.3-fpm php7.3-common php-mysql mariadb-client

# Telechargement et installation du WordPress Client
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar
RUN		cp wp-cli.phar /usr/local/bin/wp

# Installation de notre config & script.sh pour WordPress
#	-> MANDATORY : www.conf (remplacer le conf de base)
COPY	./conf/wordpress.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY	./tools /var/www/html
RUN		chmod +x /var/www/html/wordpress_start.sh

# Exposition du port 9000 pour comminiquer avec le réseau -> docker-compose.yml
EXPOSE	9000

# Lancement du script.sh de WordPress
# -> ENTRYPOINT :	Commande exécutée uniquement lors d'un demarage isolé du Container
#					Suite au docker-compose exec [...] + exécution de CMD
ENTRYPOINT	["bash", "/var/www/html/wordpress_start.sh"]

# Lancement du module PHP pour WordPress
#	--nodaemonize / -F : force l'execution au 1er plan
CMD		["/usr/sbin/php-fpm7.3", "--nodaemonize"]