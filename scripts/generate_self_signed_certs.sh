#!/usr/bin/env sh
# reference: letsencrypt.org/docs/certificates-for-localhost/
set -eu

rm    -rf /etc/letsencrypt/*
mkdir -p  /etc/letsencrypt/live/${DOMAIN_NAME}
cd        /etc/letsencrypt/live/${DOMAIN_NAME}

openssl req                \
    -x509                  \
    -newkey rsa:2048       \
    -nodes                 \
    -days 356              \
    -sha256                \
    -out     fullchain.pem \
    --keyout privkey.pem   \
    -subj '/CN=localhost'  \
    -extensions EXT -config <(printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
