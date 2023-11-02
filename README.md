
Requirements:
- Raspberry Pi
- Dietpi
- Hard Drive connected to Raspberry Pi
- Docker installed
- Kubernetes installed
- Cloudflare account

1. Generate user and password using htpasswd
```commandline
source gen-registry-user-pass.sh <USERNAME> <PASSWORD>
```
2. Label master node
```commandline
kubectl label nodes $YOUR_NODE_NAME node-type=master
```
3. Mount storage volume -> Check reference tutorial bellow to mount storage
5. Update values <> on files
   - Update <YOUR_DOMAIN> value from [ingress-route.yaml](registry/ingress-route.yaml) # Ingress route is not in used yet.
   - Update <HOSTNAME> value from [persistent-volume.yaml](registry/persistent-volume.yaml)
4. Create namespace and other K8s registry components
```commandline
kubectl apply -f registry/namespace.yaml
kubectl apply -f registry/.
```
5. Create a cloudflare tunnel
- Get the token from container
- Add public hostname -> registry.YOUR_DOMAIN
    A- With Service:
        - Service for Public Hostname -> http://docker-registry-service.docker-registry:5000 
        or `http://<SERVICE_NAME>.<NAMESPACE>:<PORT>`

    B- With Ingress route
        - Service for Public Hostname -> http://traefik.kube-system 
        or `http://<TRAEFIK_DEPLOYMENT_NAME>.<NAMESPACE>`

6. Create cloudflare tunnel
```commandline
kubectl apply -f cloudflare/namespace.yaml
kubectl -n cloudflare create secret generic cloudflare-secrets --from-literal=TUNNEL_TOKEN="YOUR_CLOUDFLARE_TUNNEL_TOKEN"
kubectl apply -f cloudflare/deployment.yaml
```
7. Login
```commandline
docker login <YOUR_DOMAIN>
```
   user: $(cat ${HOME}/temp/registry-creds/registry-user.txt)
   password: $(cat ${HOME}/temp/registry-creds/registry-pass.txt)


Reference:
- [Mount Storage Volumes onto Linux Operating Systems](http://blog.zachinachshon.com/storage-volume/)
