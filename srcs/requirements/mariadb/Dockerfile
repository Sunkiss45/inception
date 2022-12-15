# OS du container *pas le ft* & Update de celui-ci
FROM	debian:buster
RUN		apt-get -y update

# Téléchargement et installation de MariaDB
RUN		apt-get -y install mariadb-server

# Exposition du port 3306 pour comminiquer avec le réseau -> docker-compose.yml
EXPOSE	3306

# Installation de notre config & script.sh pour MariaDB
#	-> MANDATORY : 50-server.cnf (remplacer le conf de base)
COPY	./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./tools /var/www

RUN		mkdir -p /run/mysqld
RUN		chown -R mysql:root /run/mysqld
RUN		chown -R mysql:mysql /var/lib/mysql

# Lancement du script.sh de MariaDB
# -> ENTRYPOINT :	Commande exécutée uniquement lors d'un demarage isolé du Container
#					Suite au docker-compose exec [...] + exécution de CMD
ENTRYPOINT ["bash", "var/www/mariadb_start.sh"]

# Lancement du module MySQLd pour MariaDB
CMD		["mysqld"]