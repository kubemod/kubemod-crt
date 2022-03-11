#!/usr/bin/env sh
set -e

ca_bundle=$(cat /tmp/ca/ca.pem | base64 - | tr -d '\n' )

echo "Applying mutating webhook configuration patch..."
kubectl get mutatingwebhookconfiguration kubemod-mutating-webhook-configuration -o json | \
  jq -cr --arg caBundle $ca_bundle '.webhooks[].clientConfig.caBundle = $caBundle' | \
  kubectl apply --record --force -f -
echo "Applying validating webhook configuration patch..."
kubectl get validatingwebhookconfiguration kubemod-validating-webhook-configuration -o json | \
  jq -cr --arg caBundle $ca_bundle '.webhooks[].clientConfig.caBundle = $caBundle' | \
  kubectl apply --record --force -f -
