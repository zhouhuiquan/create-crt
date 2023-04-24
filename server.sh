#!/usr/bin/env bash
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config /private/etc/ssl/openssl.cnf
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 36500 -sha256 -extfile v3.ext
