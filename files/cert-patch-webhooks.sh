#!/usr/bin/env sh
set -e

ca_bundle=$(cat ca.pem | base64 - | tr -d '\n' )
sed -r -i "s|Cg==|$ca_bundle|" patch-mutating-webhook-configuration.json
sed -r -i "s|Cg==|$ca_bundle|" patch-validating-webhook-configuration.json

echo "Applying mutating webhook configuration patch..."
kubectl patch mutatingwebhookconfiguration kubemod-mutating-webhook-configuration --type=json --patch "$(cat patch-mutating-webhook-configuration.json)"
echo "Applying validating webhook configuration patch..."
kubectl patch validatingwebhookconfiguration kubemod-validating-webhook-configuration --type=json --patch "$(cat patch-validating-webhook-configuration.json)"
