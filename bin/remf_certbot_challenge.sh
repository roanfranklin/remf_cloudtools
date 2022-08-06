#!/bin/bash

echo -e "\nPressione Ctrl+C a qualquer momento para sair!\n"

if [ -z "$1" ]; then
   read -p "Informe o diretório onde está as configs do Let's Encrypt: "
fi

if [ -z "$2" ]; then
   read -p "Informe o seu email: "
fi

if [ -z "$3" ]; then
   read -p "Informe o(s) domínio(s) [ ex.: domain.com.br,www.domain.com.br,app.domain.com.br ]: "
fi

DIR=$1
EMAIL=$2
DOMAINS=$3

if [ ! -d "$DIR/config" ]; then
   mkdir $DIR/config
fi

if [ ! -d "$DIR/workdir" ]; then
   mkdir $DIR/workdir
fi

if [ ! -d "$DIR/logs" ]; then
   mkdir $DIR/logs
fi

DATA_DOMAINS=""
MYIFS=$IFS
IFS=","
for xx in ${DOMAINS}; do
   DATA_DOMAINS+=" -d ${xx}"
done
IFS=$MYIFS
unset MYIFS

echo -e "\ncertbot certonly -m ${EMAIL} --manual --preferred-challenges dns --debug-challenges ${DATA_DOMAINS} --config-dir ${DIR}/config/ --work-dir ${DIR}/workdir/ --logs-dir ${DIR}/logs/\n"

read -p "Pressione [ENTER] para executar."

certbot certonly -m ${EMAIL} --manual --preferred-challenges dns --debug-challenges ${DATA_DOMAINS} --config-dir ${DIR}/config/ --work-dir ${DIR}/workdir/ --logs-dir ${DIR}/logs/
