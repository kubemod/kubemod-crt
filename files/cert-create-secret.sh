#!/usr/bin/env sh
set -e

echo "Generating Kubernetes certificate secret..."
kubectl create secret tls webhook-server-cert -n kubemod-system --cert=server.pem --key=server-key.pem --dry-run=client -o yaml > webhook-server-cert.yaml
echo "Applying certificate..."
kubectl apply -f webhook-server-cert.yaml -n kubemod-system