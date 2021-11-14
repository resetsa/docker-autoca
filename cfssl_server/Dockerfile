FROM cfssl/cfssl:1.6.1 as cfssl-image

FROM debian:buster-slim

MAINTAINER Sergey Stepanenko
LABEL version="0.1"
LABEL OS=Debian

ENV USERNAME cfssld
ENV DATADIR /data
ENV MAIN_CA /data/main_ca_03.crt
ENV CA_KEY /data/autoca-key.pem
ENV CA_CERT /data/autoca.pem
ENV TLS_KEY /data/autoca-tls-key.pem
ENV TLS_CERT /data/autoca-tls.pem
ENV RESP_KEY /data/responder-ocsp-key.pem
ENV RESP_CERT /data/responder-ocsp.pem

COPY --from=cfssl-image /usr/bin/cfssl /usr/bin/cfssl
COPY --from=cfssl-image /usr/bin/cfssljson /usr/bin/cfssljson
COPY --from=cfssl-image /usr/bin/cfssl-bundle /usr/bin/cfssl-bundle
COPY --from=cfssl-image /usr/bin/cfssl-certinfo /usr/bin/cfssl-certinfo
COPY --from=cfssl-image /usr/bin/cfssl-newkey /usr/bin/cfssl-newkey
COPY --from=cfssl-image /usr/bin/cfssl-scan /usr/bin/cfssl-scan
COPY --from=cfssl-image /usr/bin/mkbundle /usr/bin/mkbundle
COPY --from=cfssl-image /usr/bin/multirootca /usr/bin/multirootca

COPY $PWD/*.crt /usr/local/share/ca-certificates/
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64.tar.gz /tmp/

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates --no-install-recommends \
    && apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y nginx \
    && rm -rf /var/lib/apt/lists/ \
    && update-ca-certificates \
    && adduser --system --disabled-password $USERNAME \
    && mkdir /etc/cfssl && chmod 755 -R /etc/cfssl \
    && tar xzvf /tmp/s6-overlay-amd64.tar.gz -C /

COPY $PWD/etc /etc
COPY $PWD/etc/nginx/nginx.conf /etc/nginx/nginx.conf

RUN chmod -R 755 /etc/services.d && chmod -R 755 /etc/nginx

EXPOSE 80 8888 8889
VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER root

ENTRYPOINT ["/init"]
