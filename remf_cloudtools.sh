#!/bin/bash
#
# docker build -t roanfranklin/cloudtools:1.0 .
# cp -ra remf_cloudtools.sh /usr/loca/sbin/
# chmod +x /usr/loca/sbin/remf_cloudtools.sh
#

DIR_ATUAL=$(pwd)

DIR_MOUNTS=".kube .aws .docker .ssh"

DIR_DATA="${DIR_ATUAL}/data"

HN_PROJECT=$(pwd | awk -F/ '{print $NF}')

cd ${DIR_ATUAL}

ADD_INFO=""

if [ -f ".env" ]; then
   ADD_INFO="${ADD_INFO} --env-file .env"
fi

for DIRECTORY in $DIR_MOUNTS; do
   if [ -d "${DIRECTORY}" ]; then
      DIR_X="${DIR_ATUAL}/${DIRECTORY}"
      ADD_INFO="${ADD_INFO} --mount src=${DIR_X},target=/home/remf/${DIRECTORY},type=bind"
   fi
done

if [ ! -d "data" ]; then
	echo -e "\n [ OPS ] Você está no diretório correto???\n         falta alguns arquivos e diretório:\n\n\t ! .env\n\t ! .kube\n\t ! .aws\n\t ! .ssh\n\t ! data\n\n"

	read -p "Deseja transformar o \"${HN_PROJECT}\" em projeto? [ s | N ] " OP
	case ${OP} in
	  [sSyY]) echo -e "\nCriando os diretórios "data, .kube, .aws, .docker, .ssh" e o arquivo ".env"...\n"
             mkdir .kube .aws .docker .ssh data
             touch .env
             touch .bash_history
             ;;
	  *) echo -e "\nAté mais!\n"
             exit 0
             ;;
	esac
fi

if [ ! -f ".bash_history" ]; then
   touch .bash_history
fi

echo -e "\nOBS.: Para funcionar o docker dentro do container, é preciso mudar as permissões do \"/var/run/docker.sock\" para 777.\n\n\tsudo chmod 777 /var/run/docker.sock\n"

docker run --rm \
 --hostname "${HN_PROJECT}" ${ADD_INFO} \
 --mount src="${DIR_ATUAL}/.bash_history",target=/home/remf/.bash_history,type=bind \
 --mount src="${DIR_DATA}",target=/home/remf/projects,type=bind \
 -v /var/run/docker.sock:/var/run/docker.sock \
 --privileged -it roanfranklin/ubuntu:20.04 /bin/bash

# --privileged -it roanfranklin/cloudtools:latest /bin/bash
# -e PS1='\[\033[01;35m\][\u@\h\[\033[01;37m\] \W\[\033[01;35m\]]\$\[\033[00m\] ' \
# -e PS1='\u@\h \W \$ ' \