FROM kubesphere/kubectl:v1.20.0 as kubectl
FROM jitesoft/cfssl:latest as cfssl

FROM alpine:3.6

COPY --from=kubectl /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=cfssl /usr/local/bin/cfssl /usr/local/bin/cfssl
COPY --from=cfssl /usr/local/bin/cfssljson /usr/local/bin/cfssljson

ARG NONROOT_UID=65532
ARG NONROOT_GID=65532

RUN apk add --no-cache jq \
 && adduser -u $NONROOT_UID -D nonroot $NONROOT_GID \
 && mkdir -p -m 775 /kubemod-crt \
 && chown nonroot:root /kubemod-crt

COPY --chown=nonroot:nonroot files/ kubemod-crt/

USER nonroot

WORKDIR /kubemod-crt
