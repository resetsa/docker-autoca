FROM cfssl/cfssl:1.6.1 as cfssl-image

FROM debian:buster-slim

MAINTAINER Sergey Stepanenko
LABEL version="0.32"
LABEL OS=Debian

ENV GROUPNAME sas
ENV USERNAME sas
ENV DATADIR /data
ENV UID 1010
ENV GID 1010

COPY --from=cfssl-image /usr/bin/cfssl /usr/bin/cfssl
COPY --from=cfssl-image /usr/bin/cfssljson /usr/bin/cfssljson
COPY --from=cfssl-image /usr/bin/cfssl-bundle /usr/bin/cfssl-bundle
COPY --from=cfssl-image /usr/bin/cfssl-certinfo /usr/bin/cfssl-certinfo
COPY --from=cfssl-image /usr/bin/cfssl-newkey /usr/bin/cfssl-newkey
COPY --from=cfssl-image /usr/bin/cfssl-scan /usr/bin/cfssl-scan
COPY --from=cfssl-image /usr/bin/mkbundle /usr/bin/mkbundle
COPY --from=cfssl-image /usr/bin/multirootca /usr/bin/multirootca
RUN mkdir /etc/cfssl && chmod 755 -R /etc/cfssl

RUN apt-get update && apt-get install -y vim ca-certificates --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && addgroup --gid $GID $GROUPNAME \
    && adduser --uid $UID --gid $GID --shell /bin/bash --disabled-password $USERNAME 

COPY *.crt /usr/local/share/ca-certificates/
RUN echo "Update root ca" \
    && update-ca-certificates

COPY .vimrc /home/$USERNAME

VOLUME ["$DATADIR"]
WORKDIR $DATADIR
USER sas
ENTRYPOINT [ "/bin/bash"]
