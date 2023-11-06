#!/bin/bash
TLS_DIR=${HOME}/registry/tls

mkdir -m 777 -p ${TLS_DIR}
openssl req -newkey rsa:2048 -nodes -keyout ${TLS_DIR}/registry_auth.key -x509 -days 365 -out ${TLS_DIR}/registry_auth.crt