## traefik k8s

Instalar e configurar o Trafik em seu Cluster Kubernetes usando o HELM.

### Requerimentos

Aplicação:

- kubectl
- helm

### Config. Inicial

1º Namespace para k8s

>Pode criar um namespace em seu k8s para não usar o kube-system.
>Com o comando: kubectl create namespace ing-treafik
>
>**OBS.:** nos comandos abaixo modificar os namespaces *kube-system* para o namespace criado: *ing-traefik*.

2º Analise os 3 (três) manifestos para realiar algumas configurações/modificações como:

- modificar o *additionalArguments* e *env* do manifesto *initial_traefik.yaml*;
- modificar o domínio em *match* do manifesto *ingress_traefik.yaml*;
- criar e modificar o *users* do manifesto *auth_traefik.yaml*;

### Instalar

Adicinar repositório do traefik em seu HELM:

```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
```

Instalar em seu k8s usando o manifesto *initial_traefik.yaml*:

```bash
helm install traefik --namespace kube-system traefik/traefik --values initial_traefik.yaml
```

Em caso de modificações no manifesto *initial_traefik.yaml*, pode usar o comando:

```bash
helm upgrade traefik --namespace kube-system traefik/traefik -f initial_traefik.yaml
```

### Habilitar dashboard e autenticação

Use o comando htpasswd (apache2-utils) para gerar a senha de acesso para o traefik.

```bash
htpasswd -nbB admin "admin" | base64 -w 0
```

**OBS.:** A senha tem que está no formato base64 e pode conter N usuario e senha. Mas tem que seguir um padrão!

Com o hash acima criado, copie e cole no manifesto *auth_traefik.yaml*.

```bash
kubectl apply -f auth_traefik.yaml

kubectl apply -f ingress_traefik.yaml
```

### Manifestos ingressRoute 

Em suas aplicações/microserviços é preciso configurar o IngressRoute para o Traefik possa encaminha para ele.

```yaml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: app1
  namespace: dev
spec:
  entryPoints:
    - websecure
  routes:
    - kind: Rule
      match: Host(`dev.meudominio.com.br`)
      services:
        - name: app1
          port: 3000
  tls:
    certResolver: aws
```

Em seu serviço de DNS, pode ser RegistroBR ou no Route53(AWS) precisa criar o apontamento *dev.meudominio.com.br* apontando para o Cluster Kubernetes.

**OBS.:** Se estiver usando o minikube (https://github.com/roanfranklin/lab-minikube) com o *metallb* você pode adicionar o domínio em seu */etc/hosts*.