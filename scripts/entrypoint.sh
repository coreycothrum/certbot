#!/usr/bin/env sh
set -eu

trap exit TERM;

while :
do
  certbot renew
  sleep 12h &
  wait $!
done;
