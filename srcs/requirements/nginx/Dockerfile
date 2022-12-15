# OS du container *pas le ft* & Update de celui-ci
FROM	debian:buster
RUN		apt-get -y update

# Telechargement et installation de Nginx & OpenSSL (pour TLSv1.3)
RUN		apt-get install -y nginx openssl

# Installation de notre config pour Nginx
COPY	./conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Création du dossier de travail du Container *toujours pas le ft*
# WORKDIR /var/www/html/wordpress
RUN		mkdir -p /var/www/html/wordpress

# Configuration du SSL pour Nginx
# - openssl : Creation de connection SSL / "Create self-signed certificate and new private key from scratch"
#		avec certificat X.509 (-x509)
#		sans cryptage (-nodes)
#		avec durer de validiter 1 an (-days)
#		avec key sur 2048 bits (-rsa)
# - out : Creation de Certificat pour une "private key".
# - keyout : Creation d'une "private key" avec un certificat, sans mot de passe, sans cryptage.
# - subj : Entrer de nos informations.
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-out /etc/ssl/certs/nginx.crt \
		-keyout /etc/ssl/certs/nginx.key \
		-subj '/C=FR/ST=75/L=Paris/O=42/OU=ebarguil/CN=ebarguil.42.fr'

# Exposition du port 443 pour Internet -> docker-compose.yml
EXPOSE	443

# Lancement du Nginx
#	-g : Directive de configuration global
#	daemon off; : pas de virtualisation du nginx 
#		! "virtualisation off" = Execution au 1er plan !
#		! arret automatique apres lancement si absent !
CMD		["/usr/sbin/nginx", "-g", "daemon off;"]