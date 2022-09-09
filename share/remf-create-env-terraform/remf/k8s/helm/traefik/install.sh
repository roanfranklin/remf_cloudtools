#!/bin/bash

helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik --namespace kube-system --values values-traefik.yaml --create-namespace --wait

# helm upgrade traefik traefik/traefik --namespace kube-system -f values-traefik.yaml

htpasswd -nbB admin "admin" | base64 -w 0

kubectl apply -f auth_traefik.yaml

kubectl apply -f ingress_traefik.yaml
