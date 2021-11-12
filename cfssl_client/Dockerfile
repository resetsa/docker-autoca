FROM cfssl/cfssl:1.6.1

ENV GROUPNAME sas
ENV USERNAME sas
ENV DATADIR /data

RUN apt-get update && apt-get install -y bash vim openssh-server mc \
    && rm -rf /var/lib/apt/lists/* \
    && adduser --shell /bin/bash --disabled-password $USERNAME \
    && echo "Config ssh" \
    && ssh-keygen -A \
    && echo "Port 22" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config \
    && mkdir /run/sshd \
    $$ echo "Prepare authorized_keys" \
    && mkdir -p /home/$USERNAME/.ssh

COPY *.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates

COPY .ssh/authorized_keys /home/$USERNAME/.ssh/authorized_keys

RUN echo "Edit rigths to authorized_keys" \
    && chmod 600 /home/$USERNAME/.ssh/authorized_keys \ 
    && chown -R $USERNAME:$GROUPNAME /home/$USERNAME/ \
    && chmod 700 /home/$USERNAME/.ssh

COPY .vimrc /home/$USERNAME

VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER root
EXPOSE 22
ENTRYPOINT [ "/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]
