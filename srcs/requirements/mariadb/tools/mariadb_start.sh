#!/bin/bash

if [ ! -d /var/lib/mysql/wordpress ]; then

	# Ouverture du shell mysql
	mysqld&

	# En attente de réponse du module mysqld
	until mysqladmin ping; do
		sleep 1
	done

	# Exécution des commandes pour configurer notre Container MariaDB
	echo "create database if not exists wordpress;" | mysql -u root
	echo "create user if not exists '$LOGIN' identified by '$PASSWORD';" | mysql -u root
	echo "grant usage on wordpress.* TO '$LOGIN'@'%' identified by '$PASSWORD';" | mysql -u root
	echo "grant all privileges on wordpress.* TO '$LOGIN'@'%' with grant option;" | mysql -u root
	echo "flush privileges;" | mysql -u root
	echo "alter user 'root'@'localhost' identified by '$PASSWORD';" | mysql -u root

	# Arret du module mysqld -> arret de MariaDB
	killall mysqld
fi

# Exécution du script
#	HELP - https://stackoverflow.com/a/48096779
#	-> Exécute les commandes ci-dessus comme dans un shell, en évitant les pid dédoublé (zombie)
exec "$@"