FROM cfssl/cfssl
ENV USERNAME cfssld
ENV DATADIR /data
ENV MAIN_CA /data/main_ca_03.crt
ENV CA_KEY /data/autoca-key.pem
ENV CA_CERT /data/autoca.pem
ENV TLS_KEY /data/autoca-tls-key.pem
ENV TLS_CERT /data/autoca-tls.pem

ENV RESP_KEY /data/responder-ocsp-key.pem
ENV RESP_CERT /data/responder-ocsp.pem

COPY $PWD/*.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates
RUN adduser --system --disabled-password $USERNAME

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY $PWD/etc /etc
RUN chmod -R 755 /etc/services.d

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -f bash \
    && apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY $PWD/etc/nginx/nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /etc/nginx

EXPOSE 80 8888 8889
VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER root

ENTRYPOINT ["/init"]
