FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG DOCKER_BUILDKIT=1
ARG COMPOSE_DOCKER_CLI_BUILD=1

RUN apt update && apt install -y sudo \
    vim wget gnupg2 perl curl \
    docker unzip apache2-utils openssh-client \
    ansible mysql-client python3-pip python3-dev \
    git telnet iputils-ping \
    apt-transport-https ca-certificates gnupg \
    certbot

# Install Google Cloud Console
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-sdk -y

    # Extrar install ( https://cloud.google.com/sdk/docs/install#deb )
    # google-cloud-cli
    # google-cloud-cli-anthos-auth
    # google-cloud-cli-app-engine-go
    # google-cloud-cli-app-engine-grpc
    # google-cloud-cli-app-engine-java
    # google-cloud-cli-app-engine-python
    # google-cloud-cli-app-engine-python-extras
    # google-cloud-cli-bigtable-emulator
    # google-cloud-cli-cbt
    # google-cloud-cli-cloud-build-local
    # google-cloud-cli-cloud-run-proxy
    # google-cloud-cli-config-connector
    # google-cloud-cli-datalab
    # google-cloud-cli-datastore-emulator
    # google-cloud-cli-firestore-emulator
    # google-cloud-cli-gke-gcloud-auth-plugin
    # google-cloud-cli-kpt
    # google-cloud-cli-kubectl-oidc
    # google-cloud-cli-local-extract
    # google-cloud-cli-minikube
    # google-cloud-cli-nomos
    # google-cloud-cli-pubsub-emulator
    # google-cloud-cli-skaffold
    # google-cloud-cli-spanner-emulator
    # google-cloud-cli-terraform-validator
    # google-cloud-cli-tests
    # kubectl


# Install Cliente PostgreSQL 11
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list

RUN apt update && apt -y install postgresql-11

# Install kubectl ( Kubernetes )
RUN curl -L https://dl.k8s.io/v1.10.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Install HELM
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh && chmod 700 get_helm.sh && ./get_helm.sh

# Install ECS-CLI ( AWS ecsctl )
RUN curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest && chmod +x /usr/local/bin/ecs-cli

# Install EKS ( AWS - eksctl )
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && mv /tmp/eksctl /usr/local/bin/eksctl && chmod +x /usr/local/bin/eksctl

# Install Terraform
ENV TERRAFORM_VERSION 1.0.4
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Ansible
# Já está no primeiro apt install!

COPY bin/remf_* /usr/local/sbin/ 
RUN chmod 0755 /usr/local/sbin/remf_*

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
