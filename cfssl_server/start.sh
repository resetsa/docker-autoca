#!/bin/sh
/usr/bin/cfssl serve -ca-bundle $MAIN_CA -ca-key $CA_KEY -ca $CA_CERT -config /data/config.json -tls-cert $TLS_CERT -tls-key $TLS_KEY -db-config /data/db_config.json -address 0.0.0.0 -responder $RESP_CERT -responder-key $RESP_KEY -loglevel=0
