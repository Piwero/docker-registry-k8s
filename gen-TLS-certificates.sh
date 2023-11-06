#!/bin/bash
CERT_DIR=${HOME}/registry/tls

mkdir -m 777 -p ${CERT_DIR}
openssl req -newkey rsa:2048 -nodes -keyout ${CERT_DIR}/registry_auth.key -x509 -days 365 -out ${CERT_DIR}/registry_auth.crt