**see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) for an usage example**

this project [is deployed to docker hub](https://hub.docker.com/repository/docker/coreycothrum/certbot)

### what this image is
an extention of the official [certbot docker image](https://hub.docker.com/r/certbot/certbot) to make things a bit easier. Namely:
* helper script to generate temporary self-signed certificate(s) to "seed" the webserver.
* helper script to obtain the legit certificates automatically (based the [env variables](#environment-variables)).
* certbot will check for renewal automatically (every 12 hours)

The goal of this image is to:
1. be easy to use
2. not require any further intervention after initial configuration

## environment variables
Defaults are defined in `.env`. These defaults are fine for a localhost/development environment, but should all be changed for anything resembling production (or running on a valid/public domain).

| variable name          | default value         | description                                                         |
| ---------------------- | --------------------- | ------------------------------------------------------------------- |
| `DOMAIN_NAME`          | `localhost.localhost` | domain name of server. Default is OK for local development.         |
| `DOMAIN_EMAIL`         |                       | email for important CERTBOT notifications. Can be left blank/empty. |

## Intial Setup
The following helper scripts are provided to aid in initial setup. These should only need to run (successfully) once. After certificates are obtained, they'll be renewed automatically.

**The README for [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) may be an easier example to follow**

### seeding with self-signed certificates
Project initialization often presents a chicken-and-the-egg problem:
* certbot requires a webserver running to issue certs
* the webserver requires the certs to run

To generate self-signed certificates to seed the webserver, override the entrypoint with `generate_self_signed_certs.sh`:

    docker run --rm                                       \
               --env-file .env                            \
               --volume SSL_CERTS:/etc/letsencrypt:rw     \
               --entrypoint generate_self_signed_certs.sh \
               coreycothrum/certbot

### requesting certificates via certbot
After the webserver is running (probably w/ [self-signed certificates](#seeding-with-self-signed-certificates)), the real certificates can be requested from [letsencrypt.com](letsencrypt.com) with this command:

    docker run --rm                                   \
               --env-file .env                        \
               --volume SSL_CERTS:/etc/letsencrypt:rw \
               --entrypoint request_certs.sh          \
               coreycothrum/certbot
