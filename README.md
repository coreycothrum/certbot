this docker image is meant to be used in conjunction with another webserver/docker.
see [this repo](https://github.com/coreycothrum/nginx_docker_compose) as an example.

## environment variables
appropriate defaults are defined in `.env`

**`DOMAIN_NAME` should be changed in any production/real (i.e. not localhost) deployment.** The others should be left alone.

| variable name  | default value         | description                 |
| -------------- | --------------------- | --------------------------- |
| `CONFIG_PATH`  | `/etc/letsencrypt`    | *should not need to change* |
| `DOMAIN_NAME`  | `localhost.localhost` | domain name of server       |
| `WEBROOT_PATH` | `/var/www/certbot`    | *should not need to change* |

## seeding with self-signed certificates
Project initialization often presents a chicken-and-the-egg problem:
* certbot requires a webserver running to issue certs
* the webserver requires the certs to run

To see with self-signed certificates, override the entrypoint with `generate_self_signed_certs.sh`:

    docker run --rm                                       \
               --env-file .env                            \
               --volume SSL_CERTS:$CONFIG_PATH:rw         \
               --entrypoint generate_self_signed_certs.sh \
               coreycothrum/certbot
