#!/bin/bash

REGISTRY_USER=${1:-admin}
REGISTRY_PASS=${2:-registry}
AUTH_DIR=${HOME}/registry/auth

# Backup credentials to local files (in case you'll forget them later on)
mkdir -m 777 -p ${AUTH_DIR}

echo ${REGISTRY_USER} >> ${AUTH_DIR}/registry-user.txt
echo ${REGISTRY_PASS} >> ${AUTH_DIR}/registry-pass.txt

sudo docker run --entrypoint htpasswd registry:2.7.0 \
    -Bbn ${REGISTRY_USER} ${REGISTRY_PASS} \
    > ${AUTH_DIR}/htpasswd

unset REGISTRY_USER REGISTRY_PASS