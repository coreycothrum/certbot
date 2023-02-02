FROM certbot/certbot:v2.2.0

VOLUME ["/etc/letsencrypt", "/var/www/certbot"]

COPY scripts/* /usr/bin/

ENTRYPOINT ["entrypoint.sh"]
