#!/usr/bin/env bash
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -days 36500 -out ca.crt
