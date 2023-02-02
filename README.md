[this docker image](https://hub.docker.com/repository/docker/coreycothrum/certbot) is meant to be used in conjunction with another webserver/docker/image

**see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) as an example**

### what this image is
an extention of the official [certbot docker image](https://hub.docker.com/r/certbot/certbot) to make things a bit easier. Namely:
* script to generate temporary self-signed certificate(s) to "seed" your webserver.
* certbot will obtain the legit certificates automatically (based the [env variables](#environment-variables)).
* certbot will check for renewal automatically (every 12 hours)

The goal of this image is to:
1. be easy to use
2. not require any further intervention after being started

## environment variables
Defaults are defined in `.env`. These defaults are fine for a localhost/development environment, but should all be changed for anything resembling production (or a valid/public domain).

| variable name          | default value         | description                                                         |
| ---------------------- | --------------------- | ------------------------------------------------------------------- |
| `DOMAIN_NAME`          | `localhost.localhost` | domain name of server                                               |
| `DOMAIN_EMAIL`         |                       | email for important CERTBOT notifications. Can be left blank/empty. |

## seeding with self-signed certificates
Project initialization often presents a chicken-and-the-egg problem:
* certbot requires a webserver running to issue certs
* the webserver requires the certs to run

To see with self-signed certificates, override the entrypoint with `generate_self_signed_certs.sh`:

    docker run --rm                                       \
               --env-file .env                            \
               --volume SSL_CERTS:/etc/letsencrypt:rw     \
               --entrypoint generate_self_signed_certs.sh \
               coreycothrum/certbot
