FROM cfssl/cfssl:1.6.1

ENV GROUPNAME sas
ENV USERNAME sas
ENV DATADIR /data

RUN apt-get update && apt-get install -y bash vim mc \
    && rm -rf /var/lib/apt/lists/* \
    && adduser --shell /bin/bash --disabled-password $USERNAME 

COPY *.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates

COPY .vimrc /home/$USERNAME

VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER sas
ENTRYPOINT [ "/bin/bash"]
