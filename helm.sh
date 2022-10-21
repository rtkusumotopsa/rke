helm repo add traefik https://helm.traefik.io/traefik
helm repo update

kubectl create ns traefik-v2
# Install in the namespace "traefik-v2"
helm install --namespace=traefik-v2 \
    traefik traefik/traefik

kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name -n traefik-v2) 9000:9000 -n traefik-v2
