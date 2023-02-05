#!/usr/bin/env sh
set -e

################################################################################
CMD_BASE="certbot certonly --webroot --webroot-path /var/www/certbot --force-renew --non-interactive --agree-tos"

if [ -z "$DOMAIN_EMAIL" ]; then
  CMD_BASE="$CMD_BASE --register-unsafely-without-email"
else
  CMD_BASE="$CMD_BASE -m $DOMAIN_EMAIL"
fi

################################################################################
set -eu

rm -fr /etc/letsencrypt/*/${DOMAIN_NAME}

################################################################################
CMD_TEST="${CMD_BASE} --dry-run -d ${DOMAIN_NAME}"
CMD_EXEC="${CMD_BASE}           -d ${DOMAIN_NAME}"

eval $CMD_TEST && eval $CMD_EXEC
