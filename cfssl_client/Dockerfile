FROM cfssl/cfssl:1.6.1 as cfssl-image

FROM debian:buster-slim

MAINTAINER Sergey Stepanenko
LABEL version="0.3"
LABEL OS=Debian

ENV GROUPNAME sas
ENV USERNAME sas
ENV DATADIR /data

COPY --from=cfssl-image /usr/bin/cfssl /usr/bin/cfssl
RUN mkdir /etc/cfssl && chmod 755 -R /etc/cfssl

RUN apt-get update && apt-get install -y vim ca-certificates --no-install-recommends \
    && apt-get clean \
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
