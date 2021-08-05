Container com ferramentas para Cloud. aws-cli, eksctl, kubectl, docker-cli, helm, tfswitch, docker-cli, outros e alguns scritps para ajudar!

## Apps - Requisitos

- Docker

## Install

Copiar o script "remf_cloudtools.sh" para "/usr/local/sbin/" e dar permissão de execução!

```
cp remf_cloudtools.sh /usr/local/sbin/
chmod +x /usr/local/sbin/remf_cloudtools.sh
```

## Obrigatório

O diretório que vocẽ está, será o hostname do container. Também deve existir o diretório **data**, pois ele será o diretório de projetos.

## Opcional

Você pode ter em cada "cliente" os diretório (.aws .kube .docker .ssh), que serão montados com tipo bind no container!
