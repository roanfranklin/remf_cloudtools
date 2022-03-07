Container com ferramentas para Cloud e serviços como:

- aws-cli
- gcloud
- ecs-cli
- eksctl
- kubectl
- docker-cli
- helm
- terraform
- ansible
- ...

Também ten algums scripts que dentro do container para ajudar. Estão em */usr/loca/sbin/* e iniciam com *remf_*!

- remf_aws_checklist_service.py
- remf_aws_identify.sh
- remf_k8s_force-delete-namespace.py
- remf_k8s_yaml_lint.py
- ...

### Apps - Requisitos

- Docker

### Install

Copiar o script "remf_cloudtools.sh" para "/usr/local/sbin/" e dar permissão de execução!

```
cp remf_cloudtools.sh /usr/local/sbin/
chmod +x /usr/local/sbin/remf_cloudtools.sh
```

### Como usar

- Obrigatório

O diretório que vocẽ está, será o hostname do container. Também deve existir o diretório **data**, pois ele será o diretório de projetos.

- Opcional

Você pode ter em cada "cliente" os diretório (.aws .kube .docker .ssh), que serão montados com tipo bind no container!
