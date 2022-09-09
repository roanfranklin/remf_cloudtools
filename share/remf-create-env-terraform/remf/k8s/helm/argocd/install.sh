#!/bin/bash

# wget https://raw.githubusercontent.com/argoproj/argo-helm/main/charts/argo-cd/values.yaml
# git clone https://github.com/argoproj/argo-helm.git

helm init
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install argcd bitnami/argo-cd --namespace argocd-system --create-namespace --wait

helm upgrade argcd bitnami/argo-cd \
    namespace argocd-system \
    server.insecure true \
    server.ingress.enabled true \
    server.ingress.hostname "argocd.remf.net.br"

--server.config.ingress.insecure=true --set server.config.ingress.hostname=argocd.remf.net.br

kubectl get all -n argocd-system

echo "Username: admin"
echo "Password: $(kubectl -n argocd-system get secret argocd-secret -o jsonpath="{.data.clearPassword}" | base64 -d)"


# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# # kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# # kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "ClusterIP"}}'

# kubectl apply -f ingress_argocd.yaml

# kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2