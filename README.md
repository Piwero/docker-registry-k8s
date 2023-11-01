
Requirements:
- Raspberry Pi
- Dietpi
- Hard Drive connected to Raspberry Pi
- Docker installed
- Kubernetes installed
- Cloudflare account

1. Generate user and password using htpasswd
You can edit the script with your own user and password.
```commandline
source gen-registry-user-pass.sh
```
2. Label master node
```commandline
kubectl label nodes $YOUR_NODE_NAME node-type=master
```
3. Mount storage volume -> Check reference tutorial bellow to mount storage
5. Update values <> on files
   - Update <YOUR_DOMAIN> value from [ingress-route.yaml](registry/ingress-route.yaml)
   - Update <HOSTNAME> value from [persistent-volume.yaml](registry/persistent-volume.yaml)
4. Create namespace and other K8s registry components
```commandline
kubectl apply -f registry/namespace.yaml
kubectl apply -f registry/.
```
5. Create a cloudflare tunnel and get token from container

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
