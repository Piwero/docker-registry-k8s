Create the secret from the .env file with the following command:
`kubectl create secret generic cloudflare-secret --from-env-file=traefik/.env -n docker-registry-cf`