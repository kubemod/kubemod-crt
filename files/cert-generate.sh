#!/usr/bin/env sh
set -e

echo "Generating certificates..."

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=kubemod-webhook-service.kubemod-system.svc \
  -profile=server \
  server-csr.json | cfssljson -bare server
