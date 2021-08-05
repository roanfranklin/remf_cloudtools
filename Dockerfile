FROM alpine/k8s:1.19.8

RUN apk update && apk upgrade && apk add --no-cache \
    vim perl curl wget busybox-extras su-exec sudo \
    docker-cli unzip libc6-compat apache2-utils openssh

RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

ENV USER=remf
ENV UID=1000
ENV GID=1000

RUN test -z $(getent group $GID | cut -d: -f1) || \
      groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

RUN addgroup -g "$GID" -S "$USER" && adduser \
   --disabled-password \
   -g "$GID" \
   -D \
   -s "/bin/bash" \
   -h "/home/$USER" \
   -u "$UID" \
   -G "$USER" "$USER" && exit 0 ; exit 1

RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo -e "\nset mouse=" >> /etc/vim/vimrc

RUN pip3 install requests

COPY cloud_bin/remf_* /usr/local/sbin/
RUN chmod +x /usr/local/sbin/remf_*

USER $USER

WORKDIR /home/$USER/projects

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
