helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

kubectl create namespace cattle-system

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml

helm repo add jetstack https://charts.jetstack.io

# Adicionado o traefik no repositório do helm
helm repo add traefik https://helm.traefik.io/traefik

helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1
sleep 30
kubectl get pods --namespace cert-manager

helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.k8s.net \
  --set bootstrapPassword=admin

kubectl -n cattle-system rollout status deploy/rancher


#admin1234admin
