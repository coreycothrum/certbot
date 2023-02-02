#!/usr/bin/env bash
set -eu

docker build -t coreycothrum/certbot:$(git describe --always --tags --dirty) .
