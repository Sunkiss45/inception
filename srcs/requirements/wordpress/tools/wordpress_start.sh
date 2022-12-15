#!/bin/bash

# Patch d'erreur de "No such file or directory"
mkdir -p /var/run/php/;
touch /var/run/php/php7.3-fpm.pid;

# Téléchargement de WorPress
#	* --allow-root : Accès root autorisé
wp core download --allow-root

# Création de la configuration WordPress
#	* --dbname : Initialisation du nom de la DataBase
#	* --dbuser : Initialisation de l'utilisateur
#	* --dbpass : Initialisation du mot de passe
#	* --dbhost : Initialisation de l'hebergeur de la DataBase
#	* --dbcharset : Initialisation la taille de stockage d'un "char" & "char speciaux"
#		-> ! "utf8" = "utf8mb3", coder sur 3 BYTES (octets) > "utf8mb4" coder sur 4 BYTES (octets) !
#	* --dbcollate : Initialisation du code utilisé pour encoder nos "dbcharset"
#		-> ! "utf8" = "utf8mb3", coder sur 3 BYTES (octets) > "utf8mb4" coder sur 4 BYTES (octets) !
#	* --force : Ecrase les fichier existant
#	* --allow-root : Accès root autorisé
wp config create --dbname=wordpress --dbuser=$LOGIN --dbpass=$PASSWORD --dbhost=mariadb --dbcharset="utf8mb4" --dbcollate="utf8mb4_unicode_ci" --force --allow-root
# - Why unicode / general ? https://stackoverflow.com/a/766996

# Installation de la configuration WordPress
#	* --url : Initialisation l'url utilisée
#	* --title : Initialisation le titre de WordPress
#	* --admin_user : Initialisation de l'utilisateur admin
#	* --admin_password : Initialisation du mot de passe de l'utilisateur admin
#	* --admin_email : Initialisation du mail de l'utilisateur admin
#	* --skip-email : N'enverra pas d'email au compte admin créé
#	* --allow-root : Accès root autorisé
wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$LOGIN --admin_password=$PASSWORD --admin_email=$EMAIL --skip-email --allow-root

# Création d'un nouvelle utilisateur GUEST
#	* --user_pass : Initialisation du mot de passe de GUEST
#	* --allow-root : Accès root autorisé
wp user create $GUEST_LOGIN $GUEST_EMAIL --user_pass=$GUEST_PWD --allow-root

# Modification du cgi.pathinfo
#	1 -> 0 pour désactiver, Nginx de démarent pas dans ce cadre
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini;

# Exécution du script
#	HELP - https://stackoverflow.com/a/48096779
#	-> Exécute les commandes ci-dessus comme dans un shell, en évitant les pid dédoublé (zombie)
exec "$@"