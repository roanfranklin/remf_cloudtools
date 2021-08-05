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
	echo -e "\n [ OPS ] Você está no diretório correto???\n         falta alguns arquivos e diretório:\n\n\t ! .env\n\t ! .kube\n\t ! .aws\n\t ! data\n\n"

	read -p "Deseja transformar o \"${HN_PROJECT}\" em projeto? [ s | N ] " OP
	case ${OP} in
	  [sSyY]) echo -e "\nCriando os diretórios "data, .kube, .aws, .docker" e o arquivo ".env"...\n"
             mkdir .kube .aws .docker data
             touch .env
             ;;
	  *) echo -e "\nAté mais!\n"
             exit 0
             ;;
	esac
fi

docker run --rm \
 --hostname "${HN_PROJECT}" ${ADD_INFO} \
 --mount src="${DIR_DATA}",target=/home/remf/projects,type=bind \
 -e PS1='\[\033[01;35m\][\u@\h\[\033[01;37m\] \W\[\033[01;35m\]]\$\[\033[00m\] ' \
 -it roanfranklin/cloudtools:1.0 /bin/bash

# -e PS1='\u@\h \W \$ ' \
