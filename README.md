Reference:
- [Tutorial](https://blog.zachinachshon.com/docker-registry/)
- [Mount Storage Volumes onto Linux Operating Systems](http://blog.zachinachshon.com/storage-volume/)

Requirements:
- Docker
- Kubernetes
- Helm

1. Generate user and password using htpasswd

```commandline
source 1-auth.sh
```
2. Label master node
```commandline
kubectl label nodes $YOUR_NODE_NAME node-type=master
```
3. Mount storage volume -> Check reference above to follow post
4. Create namespace, persistent volume and persistent volume claim (You might run the next command twice)
```commandline
kubectl apply -f registry/.
```
5. Install helm chart
```commandline
helm repo add twuni https://helm.twun.io
helm repo update
helm search repo docker-registry
```
Get the latest chart version
```commandline
CHART_VERSION = ADD_CHART_VERSION
helm upgrade --install docker-registry \
    --namespace container-registry \
    --set replicaCount=1 \
    --set persistence.enabled=true \
    --set persistence.size=60Gi \
    --set persistence.deleteEnabled=true \
    --set persistence.storageClass=docker-registry-local-storage \
    --set persistence.existingClaim=docker-registry-pv-claim \
    --set secrets.htpasswd=$(cat $HOME/temp/registry-creds/htpasswd) \
    --set nodeSelector.node-type=master \
    twuni/docker-registry \
    --version $CHART_VERSION
```

6. Create cloudflare tunnel
```commandline
kubectl apply -f cloudflare/namespace.yaml
kubectl -n cloudflare create secret generic cloudflare-secrets --from-literal=TUNNEL_TOKEN="YOUR_CLOUDFLARE_TUNNEL_TOKEN"
kubectl apply -f cloudflare/deployment.yaml
```