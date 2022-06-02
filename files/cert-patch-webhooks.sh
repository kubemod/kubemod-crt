#!/usr/bin/env sh
set -e

./cert-retrieve-previous-ca.sh --kind MutatingWebhookConfiguration --object kubemod-mutating-webhook-configuration --jsonpath '.webhooks[0].clientConfig.caBundle' >> previous_ca.pem
ca_bundle=$(cat previous_ca.pem ca.pem | base64 - | tr -d '\n' )
sed -r -i "s|Cg==|$ca_bundle|" patch-mutating-webhook-configuration.json
sed -r -i "s|Cg==|$ca_bundle|" patch-validating-webhook-configuration.json

echo "Applying mutating webhook configuration patch..."
kubectl patch mutatingwebhookconfiguration kubemod-mutating-webhook-configuration --type=json --patch "$(cat patch-mutating-webhook-configuration.json)"
echo "Applying validating webhook configuration patch..."
kubectl patch validatingwebhookconfiguration kubemod-validating-webhook-configuration --type=json --patch "$(cat patch-validating-webhook-configuration.json)"
