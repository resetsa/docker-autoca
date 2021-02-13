FROM cfssl/cfssl
ENV USERNAME cfssld
ENV DATADIR /data
ENV MAIN_CA /data/main_ca_03.crt
ENV CA_KEY /data/autoca-key.pem
ENV CA_CERT /data/autoca.pem
ENV TLS_KEY /data/autoca-tls-key.pem
ENV TLS_CERT /data/autoca-tls.pem
ENV RESP_KEY /data/autoca-tls-key.pem
ENV RESP_CERT /data/autoca-tls.pem

COPY $PWD/*.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates
RUN adduser --system --disabled-password $USERNAME

COPY $PWD/start.sh /
RUN chmod 755 /start.sh

RUN apt-get update && apt-get install -y bash \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8888
VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER $USERNAME

ENTRYPOINT ["/start.sh"]
