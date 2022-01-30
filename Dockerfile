FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y sudo \
    vim wget gnupg2 perl curl \
    docker unzip apache2-utils openssh-client \
    ansible mysql-client python3-pip python3-dev

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list

RUN apt update && apt -y install postgresql-11

RUN curl -L https://dl.k8s.io/v1.10.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh && chmod 700 get_helm.sh && ./get_helm.sh

ENV TERRAFORM_VERSION 1.0.4
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip


ENV USER=remf
ENV UID=1000
ENV GID=1000

RUN groupadd --gid ${GID} --non-unique ${USER}
RUN useradd -rm -d /home/${USER} -s /bin/bash -g ${GID} -G sudo -u ${UID} ${USER}

RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo -e "\nset mouse=" >> /etc/vim/vimrc

RUN pip3 install awscli

USER ${USER}

RUN echo "PS1='\[\033[01;35m\][\u@\h\[\033[01;37m\] \W\[\033[01;35m\]]\$\[\033[00m\] '" >> /home/${USER}/.bashrc

WORKDIR /home/${USER}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
