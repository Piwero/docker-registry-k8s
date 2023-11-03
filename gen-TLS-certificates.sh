#!/bin/bash
CERT_DIR=${HOME}/temp/registry/cert

mkdir -p ${CERT_DIR}
openssl req -newkey rsa:2048 -nodes -keyout registry_auth.key -x509 -days 365 -out ${CERT_DIR}/registry_auth.crt